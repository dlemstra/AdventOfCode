#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_the_ideal_stocking_stuffer_1() {
    let (part1, _) = the_ideal_stocking_stuffer("abcdef");
    assert_eq!(609043, part1);
}

#[test]
fn test_the_ideal_stocking_stuffer_2() {
    let (part1, _) = the_ideal_stocking_stuffer("pqrstuv");
    assert_eq!(1048970, part1);
}