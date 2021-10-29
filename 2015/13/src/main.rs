extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = optimal_seating_arrangement_1(input);
    println!("Total change in happiness: {0}", part1);
}
