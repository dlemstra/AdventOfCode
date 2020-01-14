extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = elves_look_elves_say(&input);
    println!("The length of the result after 40 times: {0}", part1);
    println!("The length of the result after 50 times: {0}", part2);
}