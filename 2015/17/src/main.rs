extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = no_such_thing_as_too_much(&input, 150);
    println!("Combinations: {0}", part1);
    println!("Different ways: {0}", part2);
}
