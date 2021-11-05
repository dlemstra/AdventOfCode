extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = it_hangs_in_the_balance(&input);
    println!("Best QE: {0}", part1);
}
