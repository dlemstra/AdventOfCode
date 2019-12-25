extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let (houses_part1, houses_part2) = perfectly_spherical_house_in_a_vacuum(input.as_ref());
    println!("houses part 1: {0}", houses_part1);
    println!("houses part 2: {0}", houses_part2);
}