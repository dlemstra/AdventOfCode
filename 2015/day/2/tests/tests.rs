#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_no_math_1() {
    let (square_feet,feet) = no_math(vec![String::from("2x3x4")]);
    assert_eq!(58, square_feet);
    assert_eq!(34, feet);
}

#[test]
fn test_no_math_2() {
    let (square_feet,feet) = no_math(vec![String::from("1x1x10")]);
    assert_eq!(43, square_feet);
    assert_eq!(14, feet);
}