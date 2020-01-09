extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = all_in_a_single_night(input);
    println!("Shortest route: {0}", part1);
    println!("Longest route: {0}", part2);
}