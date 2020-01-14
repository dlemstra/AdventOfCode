#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_next_password_1() {
    let next = next_password("abcdefgh");
    assert_eq!("abcdffaa", next);
}

#[test]
fn test_next_password_2() {
    let next = next_password("ghijklmn");
    assert_eq!("ghjaabcc", next);
}