use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::iter::FromIterator;

pub fn get_string_length(input: &str, iterations: usize) -> usize {
    let mut value = input.to_string();

    for _ in 0..iterations {
        let mut temp = Vec::new();
        let chars: Vec<char> = value.chars().collect();
        let mut count = 1;

        for i in 1..chars.len() + 1 {
            if i < chars.len() && chars[i] == chars[i-1] {
                count += 1;
            } else {
                temp.push(count.to_string());
                temp.push(chars[i - 1].to_string());
                count = 1
            }
        }
        value =  String::from_iter(temp);
    }

    return value.len();
}

pub fn elves_look_elves_say(input: &str) -> (usize, usize) {

    let part1 = get_string_length(input, 40);
    let part2 = get_string_length(input, 50);

    return (part1, part2);
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}