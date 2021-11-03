use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn get_value(registers: &HashMap<&str, i64>, register: &str) -> i64 {
    match registers.get(register) {
        None => 0,
        Some(value) => *value
    }
}

pub fn opening_the_turing_lock(input: &Vec<String>, start_value: i64, result_register: &str) -> i64 {
    let mut registers: HashMap<&str, i64> = HashMap::new();
    registers.insert("a", start_value);

    let mut index: i64 = 0;
    while index >= 0 && index  < input.len() as i64 {
        let line = &input[index as usize];
        let register = &line[4..5];
        let mut increment: i64 = 1;
        match &line[0..3] {
            "hlf" => { *registers.entry(register).or_insert(0) /= 2; },
            "tpl" => { *registers.entry(register).or_insert(0) *= 3; },
            "inc" => { *registers.entry(register).or_insert(0) += 1; },
            "jmp" => { increment = line[4..line.len()].parse().unwrap(); },
            "jie" => { if get_value(&registers, register) % 2 == 0 { increment = line[7..line.len()].parse().unwrap(); }},
            "jio" => { if get_value(&registers, register) == 1 { increment = line[7..line.len()].parse().unwrap(); }},
            _ => { continue; }
        }
        index += increment;
    }
    return get_value(&registers, result_register);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
