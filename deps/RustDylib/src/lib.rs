extern crate tui;
#[allow(unused_imports)] use tui::Terminal;

#[no_mangle]
pub extern fn rustdylib_printhello() {
    println!("Hello Rust!");
}

use std::ffi::{CString, CStr};
use std::os::raw::c_char;

#[no_mangle]
pub extern fn rustdylib_uppercase(rawptr: *const c_char) -> *mut c_char {
    let s = unsafe { CStr::from_ptr(rawptr) }.to_str().unwrap();
    let upcase = s.to_uppercase();
    let cstring = CString::new(upcase).unwrap();
    cstring.into_raw()
}


#[test]
fn test_uppercase() {
    let word = "apple";
    let cstring = CString::new(word).unwrap();
    let rawptr = rustdylib_uppercase(cstring.as_ptr());
    let s = CString::from_raw(rawptr);
    assert_eq!("APPLE", s);
}
