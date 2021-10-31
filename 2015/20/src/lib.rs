extern crate divisors;

pub fn infinite_elves_and_infinite_houses(input: u64) -> u64 {
    let max = input / 10;
    for i in 1..max {
        let presents = divisors::get_divisors(i).iter().map(|x| if *x == i { 0 } else { x * 10 }).sum::<u64>() + (i * 10) + 10;
        if presents >= input {
            return i;
        }
    }

    return 0;
}
