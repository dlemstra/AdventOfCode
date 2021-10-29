#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_reindeer_olympics() {
    let distance = reindeer_olympics(
    &vec![
        String::from("Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds."),
        String::from("Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.")
    ],
    1000);

    assert_eq!(1120, distance);
}
