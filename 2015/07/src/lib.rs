use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn get_value(registers: &HashMap<String, u16>, register: &str) -> (bool, u16) {
    let number = register.parse::<u16>();
    if number.is_ok() {
        return (true, number.unwrap());
    }

    if !registers.contains_key(register) {
        return (false, 0);
    }

    return (true, *registers.get(register).unwrap());
}

fn get_new_value(registers: &HashMap<String, u16>, action: Vec<&str>) -> (bool, u16) {
    if action.len() == 1 {
        return get_value(&registers, action[0]);
    }

    if action[0] == "NOT" {
        let (found, value) = get_value(&registers, action[1]);
        return (found, !value)
    } else {
        let (found, left) = get_value(&registers, action[0]);
        if !found {
            return (found, left);
        }

        match action[1] {
            "AND" => {
                let (found, value) = get_value(&registers, action[2]);
                return (found, left & value);
            },
            "OR" => {
                let (found, value) = get_value(&registers, action[2]);
                return (found, left | value);
            },
            "LSHIFT" => return(true, left << action[2].parse::<i32>().unwrap()),
            "RSHIFT" => return(true, left >> action[2].parse::<i32>().unwrap()),
            _ => panic!("should not happen: {0}", action[1]),
        }
    }
}

pub fn some_assembly_required(input: Vec<String>) -> (u16, u16) {
    let mut registers = HashMap::new();

    loop {
        for line in &input {
            let info: Vec<&str> = line.split(" -> ").collect();

            let register = info[1].to_string();
            let action: Vec<&str> = info[0].split(" ").collect();

            let (found, value) = get_new_value(&registers, action);
            if found {
                let target = registers.get_mut(&register);
                if target.is_none() {
                    registers.insert(register, value);
                } else {
                    *target.unwrap() = value;
                }
            }
        }

        if registers.contains_key("a") {
            break;
        }
    }

    let part1 = *registers.get("a").unwrap();

    registers.clear();

    loop {
        for line in &input {
            let info: Vec<&str> = line.split(" -> ").collect();

            let register = info[1].to_string();
            let action: Vec<&str> = info[0].split(" ").collect();

            let (found, mut value) = get_new_value(&registers, action);
            if register == "b" {
                value = part1
            }

            if found {
                let target = registers.get_mut(&register);
                if target.is_none() {
                    registers.insert(register, value);
                } else {
                    *target.unwrap() = value;
                }
            }
        }

        if registers.contains_key("a") {
            break;
        }
    }

    let part2 = *registers.get("a").unwrap();

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