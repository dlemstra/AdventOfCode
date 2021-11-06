#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_let_it_snow_1() {
    let result = let_it_snow(4, 5);

    assert_eq!(6899651, result);
}

#[test]
fn test_let_it_snow_2() {
    let result = let_it_snow(6, 6);

    assert_eq!(27995004, result);
}
