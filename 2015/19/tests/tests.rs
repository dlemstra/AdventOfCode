#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_medicine_for_rudolph_1() {
    let part1 = medicine_for_rudolph(
    &vec![
        String::from("H => HO"),
        String::from("H => OH"),
        String::from("O => HH"),
        String::from(""),
        String::from("HOH")
    ]);

    assert_eq!(4, part1);
}

#[test]
fn test_medicine_for_rudolph_2() {
    let part1 = medicine_for_rudolph(
    &vec![
        String::from("H => HO"),
        String::from("H => OH"),
        String::from("O => HH"),
        String::from(""),
        String::from("HOHOHO")
    ]);

    assert_eq!(7, part1);
}
