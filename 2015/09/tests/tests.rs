#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_all_in_a_single_night() {
    let (part1, part2) = all_in_a_single_night(vec!["London to Dublin = 464".into(), "London to Belfast = 518".into(), "Dublin to Belfast = 141".into()]);
    assert_eq!(605, part1);
    assert_eq!(982, part2);
}