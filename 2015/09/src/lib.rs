use std::cmp;
use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

struct CityDistance {
    city: String,
    distance: usize,
}

fn get_shortest_route(distances: &HashMap<String, Vec<CityDistance>>, from: &str, visited: Vec<String>) -> usize {
    let mut best = std::usize::MAX;

    for city_distance in &distances[from] {
        if visited.contains(&city_distance.city) {
            continue;
        }

        let mut new_visited = visited.to_owned();
        new_visited.push(city_distance.city.to_string());

        let distance = city_distance.distance + get_shortest_route(distances, &city_distance.city, new_visited);
        best = cmp::min(best, distance);
    }

    if best == std::usize::MAX {
        return 0
    }

    return best;
}

fn get_longest_route(distances: &HashMap<String, Vec<CityDistance>>, from: &str, visited: Vec<String>) -> usize {
    let mut best = 0;

    for value in &distances[from] {
        if visited.contains(&value.city) {
            continue;
        }

        let mut new_visited = visited.to_owned();
        new_visited.push(value.city.to_string());

        let distance = value.distance + get_longest_route(distances, &value.city, new_visited);
        best = cmp::max(best, distance);
    }

    return best;
}

fn add_distance(distances: &mut HashMap<String, Vec<CityDistance>>, from: &str, to: &str, distance: usize) {
    let mut city_distances = distances.get_mut(from);
    if city_distances.is_none() {
        distances.insert(from.into(), Vec::new());

        city_distances = distances.get_mut(from);
    }

    city_distances.unwrap().push(CityDistance { city: to.into(), distance: distance });
}

pub fn all_in_a_single_night(input: Vec<String>) -> (usize, usize) {
    let mut distances = HashMap::new();

    for line in &input {
        let info: Vec<&str> = line.split(" ").collect();

        let to = info[0];
        let from = info[2];
        let distance = info[4].parse::<usize>().unwrap();

        add_distance(&mut distances, from, to, distance);
        add_distance(&mut distances, to, from, distance);
    }

    let mut part1 = std::usize::MAX;

    for (city, _) in &distances {
        let mut visited = Vec::new();
        visited.push(city.to_string());
        let distance = get_shortest_route(&distances, city, visited);
        part1 = cmp::min(part1, distance);
    }

    let mut part2 = 0;

    for (city, _) in &distances {
        let mut visited = Vec::new();
        visited.push(city.to_string());
        let distance = get_longest_route(&distances, city, visited);
        part2 = cmp::max(part2, distance);
    }

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