extern crate main;
use main::*;

fn main() {
    let input = read_input("input");
    let part1 = sum_of_all_numbers_1(&input);
    println!("Sum for part 1: {0}", part1);
    let part2 = sum_of_all_numbers_2(&input);
    println!("Sum for part 2: {0}", part2);
}
