extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = the_ideal_stocking_stuffer(input.as_ref());
    println!("lowest number with five zeroes: {0}", part1);
    println!("lowest number with six zeroes: {0}", part2);
}