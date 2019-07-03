module TUI

const deps_file = joinpath(@__DIR__, "..", "deps", "deps.jl")
include(deps_file)

debug = get(ENV, "TRAVIS", nothing) === nothing
const librustdylib = check_deps(debug = debug)

include("api.jl")

end # module TUI
