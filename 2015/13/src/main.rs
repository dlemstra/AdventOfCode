extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = optimal_seating_arrangement(input);
    println!("Total change in happiness part1: {0}", part1);
    println!("Total change in happiness part2: {0}", part2);
}
