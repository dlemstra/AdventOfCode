extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = some_assembly_required(input);
    println!("Value of wire a in part1: {0}", part1);
    println!("Value of wire a in part2: {0}", part2);
}