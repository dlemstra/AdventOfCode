#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_infinite_elves_and_infinite_houses() {
    let part1 = infinite_elves_and_infinite_houses1(130);

    assert_eq!(8, part1);
}
