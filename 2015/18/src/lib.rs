extern crate grid;
use grid::*;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn is_light_on(grid: &Grid<char>, x: i32, y: i32) -> usize {
    if x < 0 { return 0 }
    if y < 0 { return 0 }

    match grid.get(y as usize, x as usize) {
        None => return 0,
        Some(c) => if *c == '#' { return 1 } else { return 0 }
    }
}

fn neighbors_with_light_on(grid: &Grid<char>, x: i32, y: i32) -> usize {
    let mut count = 0;
    count = count + is_light_on(grid, x - 1, y - 1);
    if count > 3 { return count }
    count = count + is_light_on(grid, x, y - 1);
    if count > 3 { return count }
    count = count + is_light_on(grid, x + 1, y - 1);
    if count > 3 { return count }
    count = count + is_light_on(grid, x - 1, y);
    if count > 3 { return count }
    count = count + is_light_on(grid, x + 1, y);
    if count > 3 { return count }
    count = count + is_light_on(grid, x - 1, y + 1);
    if count > 3 { return count }
    count = count + is_light_on(grid, x, y + 1);
    if count > 3 { return count }
    count = count + is_light_on(grid, x + 1, y + 1);

    return count;
}

fn light_count(grid: &Grid<char>) -> usize {
    let mut count = 0;

    for y in 0..grid.rows() as i32 {
        for x in 0..grid.cols() as i32 {
           if is_light_on(grid, x, y) == 1 {
               count = count + 1;
           }
        }
    }

    return count;
}

fn update_grid(grid: Grid<char>, corners_cannot_be_turned_off: bool) -> Grid<char> {
    let mut result : Grid<char> = grid.clone();

    for y in 0..grid.rows() as i32 {
        for x in 0..grid.cols() as i32 {
            if corners_cannot_be_turned_off {
                if y == 0 && (x == 0 || (x + 1) as usize == grid.cols()) { continue; }
                if (y + 1) as usize == grid.rows() && (x == 0 || (x + 1) as usize == grid.cols()) { continue; }
            }

            let count = neighbors_with_light_on(&grid, x, y);
            if is_light_on(&grid, x, y) == 1 {
                if count != 2 && count != 3 {
                    result[y as usize][x as usize] = '.';
                }
            } else {
                if count == 3 {
                    result[y as usize][x as usize] = '#';
                }
            }
        }
    }

    return result;
}

pub fn like_a_gif_for_your_yard(input: &Vec<String>, steps_part1: i32, steps_part2: i32) -> (usize, usize) {
    let mut grid : Grid<char> = grid![];

    for line in input {
        grid.push_row(line.chars().collect());
    }

    let mut part1 = grid.clone();
    for _ in 0..steps_part1 {
        part1 = update_grid(part1, false);
    }

    let mut part2 = grid.clone();
    part2[0][0] = '#';
    part2[0][grid.cols() - 1] = '#';
    part2[grid.rows() - 1][0] = '#';
    part2[grid.rows() - 1][grid.cols() - 1] = '#';

    for _ in 0..steps_part2 {
        part2 = update_grid(part2, true);
    }

    return (light_count(&part1), light_count(&part2));
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
