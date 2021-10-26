use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::str;

pub fn sum_of_all_numbers_1(input: &str) -> i64 {
    let mut number = String::from("");
    let mut inside_string = false;
    let mut negative = false;
    let mut sum: i64 = 0;

    for c in input.chars() {
        if c == '"' {
            inside_string = !inside_string;
        } else if !inside_string {
            if c == '-' {
                negative = true;
            }
            else if c.is_ascii_digit() {
                number.push(c);
            }
            else
            {
                if number.len() > 0 {
                    let num: i64 = number.parse().unwrap();
                    if negative {
                        sum = sum - num;
                    } else {
                        sum = sum + num;
                    }
                    number = String::from("");
                }
                negative = false;
            }
        }
    }

    return sum
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}
