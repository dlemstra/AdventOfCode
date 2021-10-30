extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = aunt_sue(&input);
    println!("Number of Sue: {0}", part1);
    println!("Number of the real Sue: {0}", part2);
}
