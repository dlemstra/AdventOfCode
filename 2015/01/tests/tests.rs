#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_not_quite_lisp_1() {
    let floor = not_quite_lisp_1("(())");
    assert_eq!(0, floor);
}

#[test]
fn test_not_quite_lisp_2() {
    let floor = not_quite_lisp_1("()()");
    assert_eq!(0, floor);
}

#[test]
fn test_not_quite_lisp_3() {
    let floor = not_quite_lisp_1("(((");
    assert_eq!(3, floor);
}

#[test]
fn test_not_quite_lisp_4() {
    let floor = not_quite_lisp_1("(()(()(");
    assert_eq!(3, floor);
}

#[test]
fn test_not_quite_lisp_5() {
    let floor = not_quite_lisp_1("))(((((");
    assert_eq!(3, floor);
}

#[test]
fn test_not_quite_lisp_6() {
    let floor = not_quite_lisp_1("())");
    assert_eq!(-1, floor);
}

#[test]
fn test_not_quite_lisp_7() {
    let floor = not_quite_lisp_1("))(");
    assert_eq!(-1, floor);
}

#[test]
fn test_not_quite_lisp_8() {
    let floor = not_quite_lisp_1(")))");
    assert_eq!(-3, floor);
}

#[test]
fn test_not_quite_lisp_9() {
    let floor = not_quite_lisp_1(")())())");
    assert_eq!(-3, floor);
}

#[test]
fn test_not_quite_lisp_10() {
    let floor = not_quite_lisp_2(")");
    assert_eq!(1, floor);
}

#[test]
fn test_not_quite_lisp_11() {
    let floor = not_quite_lisp_2("()())");
    assert_eq!(5, floor);
}