extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = reindeer_olympics(&input, 2503);
    println!("Distance traveled: {0}", part1);
}
