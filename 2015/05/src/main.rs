extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = doesnt_he_have_intern_elves_for_this(input);
    println!("Nice strings in part 1: {0}", part1);
    println!("Nice strings in part 2: {0}", part2);
}