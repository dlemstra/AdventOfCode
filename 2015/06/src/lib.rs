use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

enum LightAction {
    On,
    Off,
    Toggle,
}

fn probably_a_fire_hazard_part1(input: &Vec<String>) -> usize {
    let mut grid =  [[false; 1000]; 1000];

    for line in input {
        let mut new_line = line.replace(" through ", ",");
        let mut action = LightAction::On;
        if new_line.starts_with("toggle ") {
            action = LightAction::Toggle;
            new_line = new_line[7..].to_owned();
        } else if new_line.starts_with("turn off ") {
            action = LightAction::Off;
            new_line = new_line[9..].to_owned();
        } else {
            new_line = new_line[8..].to_owned();
        }

        let numbers: Vec<usize> = new_line.split(",").map(|s| s.parse().unwrap()).collect();
        for y in numbers[1]..numbers[3]+1 {
            for x in numbers[0]..numbers[2]+1 {
                match action {
                    LightAction::On => grid[y][x] = true,
                    LightAction::Off => grid[y][x] = false,
                    LightAction::Toggle => grid[y][x] = !grid[y][x],
                }
            }
        }
    }

    let mut part1 = 0;
    for y in 0..1000 {
        for x in 0..1000 {
            if grid[y][x] {
                part1 += 1
            }
        }
    }

    return part1
}

fn probably_a_fire_hazard_part2(input: &Vec<String>) -> usize {
    let mut grid = [[0; 1000]; 1000];

    for line in input {
        let mut new_line = line.replace(" through ", ",");
        let mut action = LightAction::On;
        if new_line.starts_with("toggle ") {
            action = LightAction::Toggle;
            new_line = new_line[7..].to_owned();
        } else if new_line.starts_with("turn off ") {
            action = LightAction::Off;
            new_line = new_line[9..].to_owned();
        } else {
            new_line = new_line[8..].to_owned();
        }

        let numbers: Vec<usize> = new_line.split(",").map(|s| s.parse().unwrap()).collect();
        for y in numbers[1]..numbers[3]+1 {
            for x in numbers[0]..numbers[2]+1 {
                match action {
                    LightAction::On => grid[y][x] += 1,
                    LightAction::Off => {
                        if grid[y][x] > 0 {
                            grid[y][x] -= 1
                        }
                    },
                    LightAction::Toggle => grid[y][x] += 2,
                }
            }
        }
    }

    let mut part2 = 0;
    for y in 0..1000 {
        for x in 0..1000 {
            part2 += grid[y][x]
        }
    }

    return part2
}

pub fn probably_a_fire_hazard(input: Vec<String>) -> (usize, usize) {
    let part1 = probably_a_fire_hazard_part1(&input);
    let part2 = probably_a_fire_hazard_part2(&input);

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