use std::cmp;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::str;

struct Ingredient {
    capacity: i64,
    durability: i64,
    flavor: i64,
    texture: i64,
    calories: i64
}

fn read_ingredients(input: &Vec<String>) -> Vec<Ingredient> {
    let mut ingredients: Vec<Ingredient> = Vec::new();

    for line in input {
        let info: Vec<&str> = line.split(" ").collect();

        let capacity: i64 = info[2].replace(",", "").parse().unwrap();
        let durability: i64 = info[4].replace(",", "").parse().unwrap();
        let flavor: i64 = info[6].replace(",", "").parse().unwrap();
        let texture: i64 = info[8].replace(",", "").parse().unwrap();
        let calories: i64 = info[10].replace(",", "").parse().unwrap();
        ingredients.push(Ingredient{capacity, durability, flavor, texture, calories});
    }

    return ingredients;
}

fn calculate_score(indices: &Vec<usize>, ingredients: &Vec<Ingredient>) -> (i64, i64) {
    let mut capacity = 0;
    let mut durability = 0;
    let mut flavor = 0;
    let mut texture = 0;
    let mut calories = 0;
    for (i, ingredient) in ingredients.iter().enumerate() {
        capacity = capacity + (ingredient.capacity * indices[i] as i64);
        durability = durability + (ingredient.durability * indices[i] as i64);
        flavor = flavor + (ingredient.flavor * indices[i] as i64);
        texture = texture + (ingredient.texture * indices[i] as i64);
        calories = calories + (ingredient.calories * indices[i] as i64);
    }

    let score = cmp::max(0, capacity) * cmp::max(durability, 0) * cmp::max(flavor, 0) * cmp::max(texture, 0);
    let calorie_score = if calories == 500 { score } else { 0 };
    return (score, calorie_score);
}

fn find_best_score<'a>(arr: &Vec<Vec<usize>>, indices: &mut Vec<usize>, index: usize, ingredients: &Vec<Ingredient>, best_score: &mut i64, best_calorie_score: &mut i64) {
    for (i, _) in arr[index].iter().enumerate() {
        indices[index] = i;
        if index == arr.len() - 1 {
            if indices.iter().sum::<usize>() == 100 {
                let (score, calorie_score) = calculate_score(indices, ingredients);
                if score > *best_score {
                    *best_score = score;
                }
                if calorie_score > *best_calorie_score {
                    *best_calorie_score = calorie_score;
                }
            }
        }

        if index < arr.len() - 1 {
            find_best_score(arr, indices, index + 1, ingredients, best_score, best_calorie_score);
        }
    }
}

pub fn science_for_hungry_people(input: &Vec<String>) -> (i64, i64) {
    let ingredients = read_ingredients(input);
    let mut best_score: i64 = 0;
    let mut best_calorie_score: i64 = 0;

    let mut arr: Vec<Vec<usize>> = vec![];
    for _ in &ingredients {
        arr.push(vec![0; 101]);
    }

    let mut indices = arr.iter().map(|ref _x| 0).collect();
    find_best_score(&arr, &mut indices, 0, &ingredients, &mut best_score, &mut best_calorie_score);

    return (best_score, best_calorie_score);
}

pub fn read_input(file_name: &str) -> Vec<String> {
    let file = File::open(file_name).expect("file not found");
    let buf_reader = BufReader::new(file);
    return buf_reader
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();
}
