#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_no_such_thing_as_too_much() {
    let part1 = no_such_thing_as_too_much(
    &vec![
        String::from("20"),
        String::from("15"),
        String::from("10"),
        String::from("5"),
        String::from("5")
    ], 25);

    assert_eq!(4, part1);
}
