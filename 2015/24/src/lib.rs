extern crate itertools;
use itertools::Itertools;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn is_valid_remaining(numbers: &Vec<i64>, combinations: usize, expected_weight: i64) -> bool {
    for start in numbers.iter().combinations(combinations) {
        let sum = start.iter().fold(0i64, |a, b| a + *b);
        if sum == expected_weight {
            let remaining: Vec<i64> = numbers.iter().filter(|x| !start.contains(&x)).cloned().collect();
            let remaining_sum = remaining.iter().fold(0i64, |a, b| a + *b);
            if remaining_sum == expected_weight {
                return true;
            }
        }
    }
    return false;
}

fn get_qe(numbers: &Vec<i64>, combinations: usize, expected_weight: i64) -> i64 {
    let mut best_qe = i64::MAX;
    for start in numbers.iter().combinations(combinations) {
        let sum = start.iter().fold(0i64, |a, b| a + *b);
        if sum == expected_weight {
            let qe = start.iter().fold(1i64, |a, b| a * *b);
            if qe < best_qe {
                let remaining: Vec<i64> = numbers.iter().filter(|x| !start.contains(&x)).cloned().collect();
                for i in combinations..numbers.len() {
                    if is_valid_remaining(&remaining, i, expected_weight) {
                        best_qe = qe;
                        break;
                    }
                }
            }
        }
    }

    return best_qe;
}

pub fn it_hangs_in_the_balance(input: &Vec<String>) -> i64 {
    let numbers: Vec<i64> = input.iter().map(|x| x.parse().unwrap()).collect();
    let expected_weight = numbers.iter().fold(0i64, |a, b| a + *b) / 3;

    for i in 2..numbers.len() {
        let qe = get_qe(&numbers, i, expected_weight);
        if qe != i64::MAX {
            return qe;
        }
    }

    return 0;
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
