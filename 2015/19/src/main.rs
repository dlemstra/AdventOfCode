extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = medicine_for_rudolph1(&input);
    println!("Distinct molecules: {0}", part1);
    let part2 = medicine_for_rudolph2(&input);
    println!("Number of steps: {0}", part2);
}
