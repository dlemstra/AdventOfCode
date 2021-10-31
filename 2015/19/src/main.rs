extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = medicine_for_rudolph(&input);
    println!("Distinct molecules: {0}", part1);
}
