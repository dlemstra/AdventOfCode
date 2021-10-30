extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = science_for_hungry_people(&input);
    println!("Best score: {0}", part1);
    println!("Best score with 500 calories: {0}", part2);
}
