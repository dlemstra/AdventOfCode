use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn the_ideal_stocking_stuffer(input: &str) -> (usize, usize) {
    let mut part1 = 1;

    loop {
        let result = format!("{:x}", md5::compute(input.to_owned() + &part1.to_string()));

        if result.to_string().starts_with("00000") {
            break
        }

        part1 += 1;
    }

    let mut part2 = 1;

    loop {
        let result = format!("{:x}", md5::compute(input.to_owned() + &part2.to_string()));

        if result.to_string().starts_with("000000") {
            break
        }

        part2 += 1;
    }

    return (part1, part2);
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}