extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = like_a_gif_for_your_yard(&input, 100);
    println!("Lights on: {0}", part1);
}
