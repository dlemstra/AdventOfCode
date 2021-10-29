extern crate itertools;
use std::collections::HashMap;
use std::fs::File;
use std::hash::Hash;
use std::hash::Hasher;
use std::io::BufReader;
use std::io::prelude::*;
use std::str;
use itertools::Itertools;

struct Person {
    name: String,
    happiness: HashMap<String, i64>
}

impl Hash for Person {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.name.hash(state);
    }
}

impl PartialEq for Person {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name
    }
}

impl Eq for Person {}

fn read_people(input: Vec<String>) -> Vec<Person> {
    let mut people: Vec<Person> = Vec::new();

    for line in input {
        let info: Vec<&str> = line.split(" ").collect();

        if let None = people.iter().find(| &person| person.name == info[0]) {
            people.push(Person{name: String::from(info[0]), happiness: HashMap::new()});
        }
        if let Some(person) = people.iter_mut().find(| person| person.name == info[0]) {
            let mut happiness: i64 = info[3].parse().unwrap();
            if info[2] == "lose" {
                happiness = -happiness;
            }
            let other = String::from(info[10].replace(".", ""));
            person.happiness.insert(other, happiness);
        }
    }

    return people;
}

pub fn optimal_seating_arrangement_1(input: Vec<String>) -> i64 {
    let mut best_happiness: i64 = 0;
    let all_people = read_people(input);

    for people in all_people.iter().permutations(all_people.len()).unique() {
        let mut happiness: i64 = 0;
        for (pos, person) in people.iter().enumerate() {
            let prev = if pos == 0 { people.len() - 1 } else { pos - 1 };
            if let Some(prev_happiness) = person.happiness.get(&people[prev].name) {
                happiness = happiness + prev_happiness;
            }
            let next = if pos == people.len() - 1 { 0 } else { pos + 1 };
            if let Some(next_happiness) = person.happiness.get(&people[next].name) {
                happiness = happiness + next_happiness;
            }
        }
        if happiness > best_happiness {
            best_happiness = happiness;
        }
    }

    return best_happiness
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
