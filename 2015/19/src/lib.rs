use std::collections::HashSet;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

struct Replacement {
    input: String,
    output: String,
}

fn parse_input(input: &Vec<String>) -> (String, Vec<Replacement>) {
    let mut replacements : Vec<Replacement> = Vec::new();

    for i in 0..input.len() - 2 {
        let line = &input[i];
        let info: Vec<&str> = line.split(" => ").collect();
        let input = String::from(info[0]);
        let output = String::from(info[1]);
        replacements.push(Replacement{input, output});
    }

    replacements.sort_by(|a,b| b.output.len().cmp(&a.output.len()));

    return (input.last().unwrap().to_string(), replacements);
}

pub fn medicine_for_rudolph1(input: &Vec<String>) -> usize {
    let (pattern, replacements) = parse_input(input);

    let mut new_patterns : HashSet<String> = HashSet::new();

    for replacement in replacements.iter() {
        let mut substring = pattern.clone();
        while let Some(mut index) = substring.find(&replacement.input) {
            index = pattern.len() - substring.len() + index;
            let start = index + replacement.input.len();

            let mut new_pattern = pattern[0..index].to_owned();
            new_pattern.push_str(&replacement.output);
            new_pattern.push_str(&pattern[start..]);

            if !new_patterns.contains(&new_pattern) {
                new_patterns.insert(new_pattern.clone());
            }

            substring = pattern[start..].to_string();
        }
    }

    return new_patterns.len();
}

pub fn medicine_for_rudolph2(input: &Vec<String>) -> usize {
    let (mut pattern, replacements) = parse_input(input);

    let mut count = 0;
    while pattern != "e" {
        for replacement in replacements.iter() {
            let result = pattern.replacen(&replacement.output, &replacement.input, 1);
            if result != pattern {
                pattern = result;
                count = count + 1;
                break;
            }
        }
    }

    return count;
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
