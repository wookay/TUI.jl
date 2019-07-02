# code from https://github.com/felipenoris/JuliaPackageWithRustDep.jl/blob/master/deps/build.jl

ENV["CARGO_TARGET_DIR"] = @__DIR__

const rustprojname = "RustDylib"
const rustlibname = "rustdylib"
const juliapackage = "TUI"

const libname = "lib" * rustlibname

function build_dylib()
    clean()

    run(Cmd(`cargo build --release`, dir=joinpath(@__DIR__, rustprojname)))

    release_dir = joinpath(@__DIR__, "release")
    dylib = dylib_filename()

    release_dylib_filepath = joinpath(release_dir, dylib)
    @assert isfile(release_dylib_filepath) "$release_dylib_filepath not found. Build may have failed."
    mv(release_dylib_filepath, joinpath(@__DIR__, dylib))
    rm(release_dir, recursive=true)

    write_deps_file(libname, dylib, juliapackage)
end

function dylib_filename()
    @static if Sys.isapple()
        "$libname.dylib"
    elseif Sys.islinux()
        "$libname.so"
    else
        error("Not supported: $(Sys.KERNEL)")
    end
end

function write_deps_file(libname, libfile, juliapackage)
    script = """
using Libdl

function check_deps(; debug=false)
    if debug
        $libname = joinpath(@__DIR__, "$rustprojname", "target", "debug", "$libfile")
    else
        $libname = joinpath(@__DIR__, "$libfile")
    end

    if !isfile($libname)
        error("\$$libname does not exist, Please re-run Pkg.build(\\"$juliapackage\\"), and restart Julia.")
    end

    if Libdl.dlopen_e($libname) == C_NULL
        error("\$$libname cannot be opened, Please re-run Pkg.build(\\"$juliapackage\\"), and restart Julia.")
    end

    $libname
end
"""

    open(joinpath(@__DIR__, "deps.jl"), "w") do f
        write(f, script)
    end
end

function clean()
    deps_file = joinpath(@__DIR__, "deps.jl")
    isfile(deps_file) && rm(deps_file)

    release_dir = joinpath(@__DIR__, "release")
    isdir(release_dir) && rm(release_dir, recursive=true)

    dylib_file = joinpath(@__DIR__, dylib_filename())
    isfile(dylib_file) && rm(dylib_file)
end

build_dylib()
