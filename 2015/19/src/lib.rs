use std::collections::HashSet;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn medicine_for_rudolph(input: &Vec<String>) -> usize {
    let pattern = input.last().unwrap();

    let mut new_patterns : HashSet<String> = HashSet::new();

    for i in 0..input.len() - 2 {
        let line = &input[i];
        let info: Vec<&str> = line.split(" => ").collect();

        let input = info[0];
        let output = info[1];

        let mut substring = pattern.clone();
        while let Some(mut index) = substring.find(input) {
            index = pattern.len() - substring.len() + index;
            let start = index + input.len();

            let mut new_pattern = pattern[0..index].to_owned();
            new_pattern.push_str(output);
            new_pattern.push_str(&pattern[start..]);

            if !new_patterns.contains(&new_pattern) {
                new_patterns.insert(new_pattern.clone());
            }

            substring = pattern[start..].to_string();
        }
    }

    return new_patterns.len();
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
