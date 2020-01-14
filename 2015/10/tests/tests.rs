#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_elves_look_elves_say() {
    let size = get_string_length("1", 4);
    assert_eq!(6, size);
}