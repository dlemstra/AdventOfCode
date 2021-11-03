#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_opening_the_turing_lock() {
    let part1 = opening_the_turing_lock(
    &vec![
        String::from("inc a"),
        String::from("jio a, +2"),
        String::from("tpl a"),
        String::from("inc a")
    ], 0, "a");

    assert_eq!(2, part1);
}
