use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::str;

#[derive(Default)]
struct Reindeer {
    km: i32,
    duration: i32,
    rest : i32,

    distance: i32,
    remaining_duration: i32,
    remaining_rest: i32,
    points: i32
}

fn read_reindeers(input: &Vec<String>) -> Vec<Reindeer> {
    let mut reindeers: Vec<Reindeer> = Vec::new();

    for line in input {
        let info: Vec<&str> = line.split(" ").collect();

        let km: i32 = info[3].parse().unwrap();
        let duration: i32 = info[6].parse().unwrap();
        let rest: i32 = info[13].parse().unwrap();
        let remaining_duration = duration;
        reindeers.push(Reindeer{km, duration, rest, remaining_duration, .. Default::default()});
    }

    return reindeers;
}

fn take_step(reindeer: &mut Reindeer) {
    if reindeer.remaining_rest > 0 {
        reindeer.remaining_rest = reindeer.remaining_rest - 1;
        if reindeer.remaining_rest == 0 {
            reindeer.remaining_duration = reindeer.duration;
        }
    } else {
        reindeer.distance = reindeer.distance + reindeer.km;
        reindeer.remaining_duration = reindeer.remaining_duration - 1;
        if reindeer.remaining_duration == 0 {
            reindeer.remaining_rest = reindeer.rest;
        }
    }
}

pub fn reindeer_olympics(input: &Vec<String>, total_seconds: i32) -> (i32, i32) {
    let mut reindeers = read_reindeers(input);
    let mut best_distance = 0;
    let mut most_points = 0;

    for _ in 0..total_seconds {
        for reindeer in &mut reindeers {
            take_step(reindeer);
        }
        let mut max_distance = 0;
        for reindeer in &reindeers {
            if reindeer.distance > max_distance {
                max_distance = reindeer.distance;
            }
        }

        for reindeer in &mut reindeers {
            if reindeer.distance == max_distance {
                reindeer.points = reindeer.points + 1;
            }
        }
    }

    for reindeer in &reindeers {
        if reindeer.distance > best_distance {
            best_distance = reindeer.distance;
        }
        if reindeer.points > most_points {
            most_points = reindeer.points;
        }
    }

    return (best_distance, most_points);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
