extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = matchsticks(input);
    println!("Value of part1: {0}", part1);
    println!("Value of part2: {0}", part2);
}