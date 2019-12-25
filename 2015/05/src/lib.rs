use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn is_bad(value: &str) -> bool {
    for disallowed in ["ab", "cd", "pq", "xy"].iter() {
        if value.contains(disallowed) {
            return true
        }
    }
    return false
}

fn contains_three_vowels(value: &str) -> bool {
    let mut count = 0;
    for c in value.chars() {
        match c {
            'a' => count += 1,
            'e' => count += 1,
            'i' => count += 1,
            'o' => count += 1,
            'u' => count += 1,
            _ => (),
        }

        if count == 3 {
            return true
        }
    }

    return false
}

fn contains_twice_in_row(value: &str) -> bool {
    let chars = value.as_bytes();

    for i in 1..chars.len() {
        if chars[i] == chars[i-1] {
            return true
        }
    }

    return false
}

fn contains_twice_without_overlap(value: &str) -> bool {
    let chars = value.as_bytes();

    if chars.len() < 4 {
        return false
    }

    let max = chars.len()-3;
    for i in 0..max {
        for j in i+2..max+2 {
            if chars[i] == chars[j] && chars[i+1] == chars[j+1] {
                return true
            }
        }
    }

    return false
}

fn repeats_with_letter_between(value: &str) -> bool {
    let chars = value.as_bytes();

    for i in 1..chars.len()-1 {
        if chars[i-1] == chars[i+1] {
            return true
        }
    }

    return false
}

pub fn doesnt_he_have_intern_elves_for_this(input: Vec<String>) -> (usize, usize) {
    let mut part1 = 0;

    for line in &input {
        if !is_bad(&line) && contains_three_vowels(&line) && contains_twice_in_row(&line) {
            part1 += 1
        }
    }

    let mut part2 = 0;

    for line in &input {
        if contains_twice_without_overlap(&line) && repeats_with_letter_between(&line) {
            part2 += 1
        }
    }

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