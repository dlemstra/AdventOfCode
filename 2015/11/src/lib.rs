use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::iter::FromIterator;

fn is_valid_password(chars: &Vec<u8>) -> bool {
    let mut first_index = 0;
    for i in 1..chars.len() {
        if chars[i - 1] == 105 || chars[i - 1] == 111 || chars[i - 1] == 108 {
            return false;
        }

        if chars[i] == chars[i - 1] {
            if first_index == 0 {
                first_index = i;
            } else if chars[first_index] != chars[i] {
                for j in 2..chars.len() {
                    if chars[j] == chars[j - 1] + 1 && chars[j - 1] == chars[j - 2] + 1 {
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

fn increment_password(chars: &mut Vec<u8>, index: usize) {
    if chars[index] == 122 {
        chars[index] = 97;

        if index != 0 {
            return increment_password(chars, index - 1);
        }
    }

    chars[index] += 1;
}

pub fn next_password(input: &str) -> String {
    let mut chars: Vec<u8> = input.chars().map(|c| c as u8).collect();

    let index = chars.len() - 1;

    increment_password(&mut chars, index);
    while !is_valid_password(&chars) {
        increment_password(&mut chars, index);
    }

    return String::from_iter(chars.into_iter().map(|c| c as char));
}

pub fn corporate_policy(input: &str) -> (String, String) {

    let part1 = next_password(input);
    let part2 = next_password(&part1);

    return (part1, part2);
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}