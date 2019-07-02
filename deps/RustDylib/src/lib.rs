extern crate tui;
#[allow(unused_imports)] use tui::Terminal;

#[no_mangle]
pub extern fn rustdylib_printhello() {
    println!("Hello Rust!");
}
