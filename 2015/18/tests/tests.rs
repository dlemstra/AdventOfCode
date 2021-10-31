#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_like_a_gif_for_your_yard() {
    let (part1, part2) = like_a_gif_for_your_yard(
    &vec![
        String::from(".#.#.#"),
        String::from("...##."),
        String::from("#....#"),
        String::from("..#..."),
        String::from("#.#..#"),
        String::from("####..")
    ], 4, 5);

    assert_eq!(4, part1);
    assert_eq!(17, part2);
}
