use std::fs::File;
use std::collections::HashMap;
use std::io::BufReader;
use std::io::prelude::*;

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn origin() -> Point {
        Point { x: 0, y: 0 }
    }

    fn north(&self) -> Point {
        Point { x: self.x, y: self.y - 1 }
    }

    fn east(&self) -> Point {
        Point { x: self.x + 1, y: self.y }
    }

    fn south(&self) -> Point {
        Point { x: self.x, y: self.y + 1 }
    }

    fn west(&self) -> Point {
        Point { x: self.x - 1, y: self.y }
    }
}

fn move_to_direction(pos: Point, c: char) -> Point {
    match c {
        '^' => return pos.north(),
        '>' => return pos.east(),
        'v' => return pos.south(),
        '<' => return pos.west(),
        _ => panic!("should not happen: {0}", c),
    }
}

pub fn perfectly_spherical_house_in_a_vacuum(input: &str) -> (usize, usize) {
    let mut visited = HashMap::new();
    let mut pos = Point::origin();
    visited.insert(pos, 1);

    for (_, c) in input.chars().enumerate() {
        pos = move_to_direction(pos, c);
        if !visited.contains_key(&pos) {
            visited.insert(pos, 1);
        }
    }

    let part1 = visited.len();

    visited.clear();

    pos = Point::origin();
    visited.insert(pos, 1);

    let mut robo_pos = Point::origin();

    for (i, c) in input.chars().enumerate() {
        if i % 2 == 0 {
            pos = move_to_direction(pos, c);
            if !visited.contains_key(&pos) {
                visited.insert(pos, 1);
            }
        } else {
            robo_pos = move_to_direction(robo_pos, c);
            if !visited.contains_key(&robo_pos) {
                visited.insert(robo_pos, 1);
            }
        }
    }

    let part2 = visited.len();

    return (part1, part2);
}

pub fn read_input(file_name: &str) -> String {
    let file = File::open(file_name).expect("file not found");
    let mut buf_reader = BufReader::new(file);
    let mut contents = String::new();
    buf_reader.read_to_string(&mut contents).expect("unable to read file");
    return contents;
}