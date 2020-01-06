#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_matchsticks() {
    let (part1, part2) = matchsticks(vec!["\"\"".into(), "\"abc\"".into(), "\"aaa\\\"aaa\"".into(), "\"\\x27\"".into()]);
    assert_eq!(12, part1);
    assert_eq!(19, part2);
}