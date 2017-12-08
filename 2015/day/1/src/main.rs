extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let floor = not_quite_lisp_1(input.as_ref());
    println!("floor: {0}", floor);
    let position = not_quite_lisp_2(input.as_ref());
    println!("position: {0}", position);
}