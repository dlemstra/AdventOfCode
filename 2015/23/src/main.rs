extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = opening_the_turing_lock(&input, 0, "b");
    let part2 = opening_the_turing_lock(&input, 1, "b");
    println!("The value in register b for part 1: {0}", part1);
    println!("The value in register b for part 2: {0}", part2);
}
