module test_tui_hello

using Test
using TUI

TUI.rustdylib_printhello()

@test TUI.rustdylib_uppercase("apple") == "APPLE"

end # module test_tui_hello
