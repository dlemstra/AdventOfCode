#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_sum_of_all_numbers_1_1() {
    let mut sum = sum_of_all_numbers_1("[1,2,3]");
    assert_eq!(6, sum);

    sum = sum_of_all_numbers_1("{\"a\":2,\"b\":4}");
    assert_eq!(6, sum);
}

#[test]
fn test_sum_of_all_numbers_1_2() {
    let mut sum = sum_of_all_numbers_1("[[[3]]]");
    assert_eq!(3, sum);

    sum = sum_of_all_numbers_1("{\"a\":{\"b\":4},\"c\":-1}");
    assert_eq!(3, sum);
}

#[test]
fn test_sum_of_all_numbers_1_3() {
    let mut sum = sum_of_all_numbers_1("{\"a\":[-1,1]}");
    assert_eq!(0, sum);

    sum = sum_of_all_numbers_1("[-1,{\"a\":1}]");
    assert_eq!(0, sum);
}

#[test]
fn test_sum_of_all_numbers_1_4() {
    let mut sum = sum_of_all_numbers_1("[]");
    assert_eq!(0, sum);

    sum = sum_of_all_numbers_1("{}");
    assert_eq!(0, sum);
}

#[test]
fn test_sum_of_all_numbers_1_5() {
    let sum = sum_of_all_numbers_1("{\"a\":[40,2]}");
    assert_eq!(42, sum);
}

#[test]
fn test_sum_of_all_numbers_2_1() {
    let sum = sum_of_all_numbers_2("[1,2,3]");
    assert_eq!(6, sum);
}

#[test]
fn test_sum_of_all_numbers_2_2() {
    let sum = sum_of_all_numbers_2("[1,{\"c\":\"red\",\"b\":2},3]");
    assert_eq!(4, sum);
}

#[test]
fn test_sum_of_all_numbers_2_3() {
    let sum = sum_of_all_numbers_2("{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}");
    assert_eq!(0, sum);
}

#[test]
fn test_sum_of_all_numbers_2_4() {
    let sum = sum_of_all_numbers_2("[1,\"red\",5]");
    assert_eq!(6, sum);
}

#[test]
fn test_sum_of_all_numbers_2_5() {
    let sum = sum_of_all_numbers_2("[{\"d\":\"red\",{\"e\":[1,2,3,4]},\"f\":5},[40,\"red\",2]}");
    assert_eq!(42, sum);
}
