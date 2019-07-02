module TUI

const deps_file = joinpath(@__DIR__, "..", "deps", "deps.jl")
include(deps_file)
const librustdylib = check_deps(debug = false) # true

include("api.jl")

end # module TUI
