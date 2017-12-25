extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (square_feet, feet) = no_math(input);
    println!("square feet: {0}", square_feet);
    println!("feet: {0}", feet);
}