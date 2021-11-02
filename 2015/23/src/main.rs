extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = opening_the_turing_lock(&input, "b");
    println!("The value in register b: {0}", part1);
}
