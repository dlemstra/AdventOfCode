use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

macro_rules! hashmap {
    ($( $key: expr => $val: expr ),*) => {{
         let mut map = HashMap::new();
         $( map.insert($key, $val); )*
         map
    }}
}

fn check_value(message: &HashMap<&str, &str>, key: &str, value: &str) -> bool {
    match message.get(key) {
        None => return false,
        Some(val) => return value.eq(*val)
    }
}

pub fn aunt_sue(input: &Vec<String>) -> i32 {
    let message = hashmap![
        "children" => "3",
        "cats" => "7",
        "samoyeds" => "2",
        "pomeranians" => "3",
        "akitas" => "0",
        "vizslas" => "0",
        "goldfish" => "5",
        "trees" => "3",
        "cars" => "2",
        "perfumes" => "1"
    ];

    for line in input {
        let line = line.replace(",", "").replace(":", "");
        let info: Vec<&str> = line.split(" ").collect();
        let mut is_match = check_value(&message, info[2], info[3]);
        if !is_match {
            continue;
        }
        is_match = check_value(&message, info[4], info[5]);
        if !is_match {
            continue;
        }
        is_match = check_value(&message, info[4], info[5]);
        if is_match {
            return info[1].parse().unwrap();
        }
    }

    return -1
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
