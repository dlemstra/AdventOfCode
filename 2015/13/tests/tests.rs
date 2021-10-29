#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_optimal_seating_arrangement_1() {
    let happiness = optimal_seating_arrangement_1(
    vec![
        String::from("Alice would gain 54 happiness units by sitting next to Bob."),
        String::from("Alice would lose 79 happiness units by sitting next to Carol."),
        String::from("Alice would lose 2 happiness units by sitting next to David."),
        String::from("Bob would gain 83 happiness units by sitting next to Alice."),
        String::from("Bob would lose 7 happiness units by sitting next to Carol."),
        String::from("Bob would lose 63 happiness units by sitting next to David."),
        String::from("Carol would lose 62 happiness units by sitting next to Alice."),
        String::from("Carol would gain 60 happiness units by sitting next to Bob."),
        String::from("Carol would gain 55 happiness units by sitting next to David."),
        String::from("David would gain 46 happiness units by sitting next to Alice."),
        String::from("David would lose 7 happiness units by sitting next to Bob."),
        String::from("David would gain 41 happiness units by sitting next to Carol.")
    ]);

    assert_eq!(330, happiness);
}
