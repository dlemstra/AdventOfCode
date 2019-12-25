extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = probably_a_fire_hazard(input);
    println!("Lights lit in part 1: {0}", part1);
    println!("Lights lit in part 2: {0}", part2);
}