use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::str;

struct Reindeer {
    km: i32,
    duration: i32,
    rest : i32,
}

fn read_reindeers(input: &Vec<String>) -> Vec<Reindeer> {
    let mut reindeers: Vec<Reindeer> = Vec::new();

    for line in input {
        let info: Vec<&str> = line.split(" ").collect();

        let km: i32 = info[3].parse().unwrap();
        let duration: i32 = info[6].parse().unwrap();
        let rest: i32 = info[13].parse().unwrap();
        reindeers.push(Reindeer{km, duration, rest});
    }

    return reindeers;
}

fn get_distance(reindeer: &Reindeer, total_seconds: i32) -> i32 {
    let mut distance = 0;
    let mut seconds = 0;

    while seconds < total_seconds {
        let mut steps = reindeer.duration;

        seconds = seconds + steps;
        if seconds > total_seconds {
            steps = steps - (seconds - total_seconds);
        }

        distance = distance + (steps * reindeer.km);

        seconds = seconds + reindeer.rest
    }

    return distance;
}

pub fn reindeer_olympics(input: &Vec<String>, total_seconds: i32) -> i32 {
    let reindeers = read_reindeers(input);
    let mut best_distance = 0;

    for reindeer in reindeers {
        let distance = get_distance(&reindeer, total_seconds);
        if distance > best_distance {
            best_distance = distance;
        }
    }

    return best_distance;
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
