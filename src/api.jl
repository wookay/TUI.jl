# module TUI

function rustdylib_printhello()
    ccall((:rustdylib_printhello, librustdylib), Cvoid, ())
end

# module TUI
