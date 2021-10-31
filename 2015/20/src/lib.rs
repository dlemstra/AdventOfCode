extern crate divisors;
use std::collections::HashMap;

pub fn infinite_elves_and_infinite_houses1(input: u64) -> u64 {
    let max = input / 10;
    for i in 1..max {
        let presents = divisors::get_divisors(i).iter().map(|x| if *x == i { 0 } else { x * 10 }).sum::<u64>() + (i * 10) + 10;
        if presents >= input {
            return i;
        }
    }

    return 0;
}

fn get_value(delivered: &mut HashMap<u64,u8>, elf: u64) -> u64 {
    match delivered.get_mut(&elf) {
        None => 0,
        Some(value) => if *value == 50 { return 0 } else { *value += 1; return elf * 11; }
    }
}

pub fn infinite_elves_and_infinite_houses2(input: u64) -> u64 {
    let mut delivered: HashMap<u64,u8> = HashMap::new();

    for i in 1..input {
        delivered.insert(i, 1);
        let presents = divisors::get_divisors(i).iter().map(|x|
            if *x == i { 0 }
            else { get_value(&mut delivered, *x) }
        ).sum::<u64>() + (i * 11);

        if presents >= input {
            return i;
        }
    }

    return 0;
}
