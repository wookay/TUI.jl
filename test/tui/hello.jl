module test_tui_hello

using Test
using TUI

TUI.rustdylib_printhello()

@test true

end # module test_tui_hello
