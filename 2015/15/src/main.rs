extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = science_for_hungry_people(&input);
    println!("Best score: {0}", part1);
}
