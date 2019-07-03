# module TUI

function rustdylib_printhello()::Nothing
    ccall((:rustdylib_printhello, librustdylib), Cvoid, ())
end

function rustdylib_uppercase(s::String)::String
    cstring = ccall((:rustdylib_uppercase, librustdylib), Ptr{UInt8}, (Cstring,), s)
    unsafe_string(cstring)
end

# module TUI
