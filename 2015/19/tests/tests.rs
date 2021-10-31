#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_medicine_for_rudolph1_1() {
    let part1 = medicine_for_rudolph1(
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
fn test_medicine_for_rudolph1_2() {
    let part1 = medicine_for_rudolph1(
    &vec![
        String::from("H => HO"),
        String::from("H => OH"),
        String::from("O => HH"),
        String::from(""),
        String::from("HOHOHO")
    ]);

    assert_eq!(7, part1);
}

#[test]
fn test_medicine_for_rudolph2_1() {
    let part1 = medicine_for_rudolph2(
    &vec![
        String::from("e => H"),
        String::from("e => O"),
        String::from("H => HO"),
        String::from("H => OH"),
        String::from("O => HH"),
        String::from(""),
        String::from("HOH")
    ]);

    assert_eq!(3, part1);
}

#[test]
fn test_medicine_for_rudolph2_2() {
    let part1 = medicine_for_rudolph2(
    &vec![
        String::from("e => H"),
        String::from("e => O"),
        String::from("H => HO"),
        String::from("H => OH"),
        String::from("O => HH"),
        String::from(""),
        String::from("HOHOHO")
    ]);

    assert_eq!(6, part1);
}
