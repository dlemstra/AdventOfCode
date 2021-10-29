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
            } else if c.is_ascii_digit() {
                number.push(c);
            } else {
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

struct Object {
    found_red: bool,
    sum: i64
}

pub fn sum_of_all_numbers_2(input: &str) -> i64 {
    let mut word = String::from("");
    let mut number = String::from("");
    let mut inside_string = false;
    let mut is_value = false;
    let mut is_negative = false;
    let mut sum: i64 = 0;
    let mut objects: Vec<Object> = Vec::new();

    for c in input.chars() {
        if c == '"' {
            if inside_string {
                if is_value && word == "red" {
                    if let Some(obj) = objects.last_mut() {
                        obj.found_red = true;
                    }
                }
                is_value = false;
            }
            inside_string = !inside_string;
            word = String::from("");
        } else if inside_string {
            word.push(c);
        } else {
            if c.is_ascii_digit() {
                number.push(c);
            } else {
                if number.len() > 0 {
                    let mut num: i64 = number.parse().unwrap();
                    if is_negative {
                        num = -num;
                    }

                    if let Some(last) = objects.last_mut() {
                        last.sum = last.sum + num;
                    } else {
                        sum = sum + num;
                    }
                }

                number = String::from("");
                is_negative = false;
                is_value = false;
                if c == '{' {
                    objects.push(Object{found_red: false, sum: 0});
                } else if c == '}' {
                    if let Some(obj) = objects.pop() {
                        if !obj.found_red {
                            if let Some(last) = objects.last_mut() {
                                last.sum = last.sum + obj.sum;
                            } else {
                                sum = sum + obj.sum;
                            }
                        }
                    }
                } else if c == ':' {
                    is_value = true;
                } else if c == '-' {
                    is_negative = true;
                }
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
