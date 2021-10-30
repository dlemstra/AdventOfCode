#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_science_for_hungry_people() {
    let (part1, part2) = science_for_hungry_people(
    &vec![
        String::from("Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8"),
        String::from("Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3")
    ]);

    assert_eq!(62842880, part1);
    assert_eq!(57600000, part2);
}
