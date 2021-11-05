#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_it_hangs_in_the_balance() {
    let part1 = it_hangs_in_the_balance(
    &vec![
        String::from("1"),
        String::from("2"),
        String::from("3"),
        String::from("4"),
        String::from("5"),
        String::from("7"),
        String::from("8"),
        String::from("9"),
        String::from("10"),
        String::from("11")
    ]);

    assert_eq!(99, part1);
}
