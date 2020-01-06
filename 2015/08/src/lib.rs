use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn matchsticks(input: Vec<String>) -> (usize, usize) {
    let mut memory_length = 0;
    let mut string_length = 0;

    for line in &input {
        memory_length += line.len();

        let chars: Vec<char> = line.chars().collect();
        let mut i = 0;
        while i < chars.len() {
            if chars[i] == '\\' {
                if chars[i + 1] == 'x' {
                    i += 3
                } else if chars[i + 1] == '\\' {
                    i += 1
                }
            }
            if chars[i] != '"' {
                string_length += 1
            }

            i += 1
        }
    }

    let part1 = memory_length - string_length;

    string_length = 0;

    for line in &input {
        string_length += 2;
        for char in line.chars() {
            if char == '"' || char == '\\' {
                string_length += 1;
            }

            string_length += 1;
        }
    }

    let part2 = string_length - memory_length;

    return (part1, part2);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}