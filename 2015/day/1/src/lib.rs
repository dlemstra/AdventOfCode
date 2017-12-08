use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn not_quite_lisp_1(input: &str) -> i32 {
    let mut floor = 0;
    for c in input.chars() {
        if c == '(' {
            floor += 1;
        }
        else if c == ')' {
            floor -= 1;
        }
    }
    return floor;
}

pub fn not_quite_lisp_2(input: &str) -> i32 {
    let mut floor = 0;
    let mut position = 0;
    for c in input.chars() {
        if c == '(' {
            floor += 1;
        }
        else if c == ')' {
            floor -= 1;
        }
        position += 1;
        if floor == -1 {
            return position;
        }
    }
    return -1;
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}