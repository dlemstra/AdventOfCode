#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_some_assembly_required_d() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> a".into(), "x OR y -> e".into(), "x LSHIFT 2 -> f".into(), "y RSHIFT 2 -> g".into(), "NOT x -> h".into(), "NOT y -> i".into()]);
    assert_eq!(72, part1);
}

#[test]
fn test_some_assembly_required_e() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> d".into(), "x OR y -> a".into(), "x LSHIFT 2 -> f".into(), "y RSHIFT 2 -> g".into(), "NOT x -> h".into(), "NOT y -> i".into()]);
    assert_eq!(507, part1);
}

#[test]
fn test_some_assembly_required_f() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> d".into(), "x OR y -> e".into(), "x LSHIFT 2 -> a".into(), "y RSHIFT 2 -> g".into(), "NOT x -> h".into(), "NOT y -> i".into()]);
    assert_eq!(492, part1);
}

#[test]
fn test_some_assembly_required_g() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> d".into(), "x OR y -> e".into(), "x LSHIFT 2 -> f".into(), "y RSHIFT 2 -> a".into(), "NOT x -> h".into(), "NOT y -> i".into()]);
    assert_eq!(114, part1);
}

#[test]
fn test_some_assembly_required_h() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> d".into(), "x OR y -> e".into(), "x LSHIFT 2 -> f".into(), "y RSHIFT 2 -> g".into(), "NOT x -> a".into(), "NOT y -> i".into()]);
    assert_eq!(65412, part1);
}

#[test]
fn test_some_assembly_required_i() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> y".into(), "x AND y -> d".into(), "x OR y -> e".into(), "x LSHIFT 2 -> f".into(), "y RSHIFT 2 -> g".into(), "NOT x -> h".into(), "NOT y -> a".into()]);
    assert_eq!(65079, part1);
}

#[test]
fn test_some_assembly_required_x() {
    let (part1, _) = some_assembly_required(vec!["123 -> a".into(), "456 -> y".into(), "a AND y -> d".into(), "a OR y -> e".into(), "a LSHIFT 2 -> f".into(), "y RSHIFT 2 -> g".into(), "NOT a -> h".into(), "NOT y -> i".into()]);
    assert_eq!(123, part1);
}

#[test]
fn test_some_assembly_required_y() {
    let (part1, _) = some_assembly_required(vec!["123 -> x".into(), "456 -> a".into(), "x AND a -> d".into(), "x OR a -> e".into(), "x LSHIFT 2 -> f".into(), "a RSHIFT 2 -> g".into(), "NOT x -> h".into(), "NOT a -> i".into()]);
    assert_eq!(456, part1);
}