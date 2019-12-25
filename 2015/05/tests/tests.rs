#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_doesnt_he_have_intern_elves_for_this_1() {
    let (part1, _) = doesnt_he_have_intern_elves_for_this(vec![String::from("ugknbfddgicrmopn")]);
    assert_eq!(1, part1);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_2() {
    let (part1, _) = doesnt_he_have_intern_elves_for_this(vec![String::from("aaa")]);
    assert_eq!(1, part1);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_3() {
    let (part1, _) = doesnt_he_have_intern_elves_for_this(vec![String::from("jchzalrnumimnmhp")]);
    assert_eq!(0, part1);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_4() {
    let (part1, _) = doesnt_he_have_intern_elves_for_this(vec![String::from("haegwjzuvuyypxyu")]);
    assert_eq!(0, part1);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_5() {
    let (part1, _) = doesnt_he_have_intern_elves_for_this(vec![String::from("dvszwmarrgswjxmb")]);
    assert_eq!(0, part1);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_6() {
    let (_, part2) = doesnt_he_have_intern_elves_for_this(vec![String::from("qjhvhtzxzqqjkmpb")]);
    assert_eq!(1, part2);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_7() {
    let (_, part2) = doesnt_he_have_intern_elves_for_this(vec![String::from("xxyxx")]);
    assert_eq!(1, part2);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_8() {
    let (_, part2) = doesnt_he_have_intern_elves_for_this(vec![String::from("uurcxstgmygtbstg")]);
    assert_eq!(0, part2);
}

#[test]
fn test_doesnt_he_have_intern_elves_for_this_9() {
    let (_, part2) = doesnt_he_have_intern_elves_for_this(vec![String::from("ieodomkazucvgmuy")]);
    assert_eq!(0, part2);
}