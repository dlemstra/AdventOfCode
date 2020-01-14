extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = corporate_policy(&input);
    println!("Next password: {0}", part1);
    println!("Next password: {0}", part2);
}