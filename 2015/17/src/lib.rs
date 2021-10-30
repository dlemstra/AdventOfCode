extern crate itertools;
use itertools::Itertools;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn no_such_thing_as_too_much(input: &Vec<String>, total: i32) -> (i32, i32) {
    let mut sizes : Vec<i32> = vec![];

    for line in input {
        sizes.push(line.parse().unwrap());
    }

    sizes.sort();

    let mut combinations = 0;

    for i in 2..sizes.len() {
        for size in sizes.iter().combinations(i) {
            let count = size.iter().fold(0i32, |a, b| a + *b);
            if count == total {
                combinations = combinations + 1;
            }
        }
    }

    let mut sizes2: Vec<&i32> = sizes.iter().clone().collect();
    let mut sum = 0;
    while sum < total {
        sum = sum + sizes2.pop().unwrap();
    }

    let mut ways = 0;

    let n = sizes.len() - sizes2.len();
    for size in sizes.iter().combinations(n) {
        let count = size.iter().fold(0i32, |a, b| a + *b);
        if count == total {
            ways = ways + 1;
        }
    }

    return (combinations, ways);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
