extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = it_hangs_in_the_balance(&input, 3);
    let part2 = it_hangs_in_the_balance(&input, 4);
    println!("Best QE with 3 groups: {0}", part1);
    println!("Best QE with 4 groups: {0}", part2);
}
