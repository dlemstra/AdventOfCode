use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

pub fn no_math(input: Vec<String>) -> (usize, usize) {
    let mut square_feet = 0;
    let mut feet = 0;

    for line in &input {
        let mut info = line.split("x");
        let l = info.next().expect(".").to_string().parse::<usize>().unwrap();
        let w = info.next().expect(".").to_string().parse::<usize>().unwrap();
        let h = info.next().expect(".").to_string().parse::<usize>().unwrap();
        let mut arr = [l, w, h];
        arr.sort();

        square_feet += 2*l*w + 2*w*h + 2*h*l + arr[0]*arr[1];
        feet += arr[0] + arr[0] + arr[1] + arr[1] + l*w*h;
    }

    return (square_feet, feet);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}