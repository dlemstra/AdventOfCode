extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (part1, part2) = like_a_gif_for_your_yard(&input, 100, 100);
    println!("Lights on part 1: {0}", part1);
    println!("Lights on part 2: {0}", part2);
}
