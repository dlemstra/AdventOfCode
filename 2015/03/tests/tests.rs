#[cfg(test)]

extern crate main;
use main::*;

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_1() {
    let (houses, _) = perfectly_spherical_house_in_a_vacuum(">");
    assert_eq!(2, houses);
}

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_2() {
    let (houses, _) = perfectly_spherical_house_in_a_vacuum("^>v<");
    assert_eq!(4, houses);
}

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_3() {
    let (houses, _) = perfectly_spherical_house_in_a_vacuum("^v^v^v^v^v");
    assert_eq!(2, houses);
}

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_4() {
    let (_, houses) = perfectly_spherical_house_in_a_vacuum("^v");
    assert_eq!(3, houses);
}

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_5() {
    let (_, houses) = perfectly_spherical_house_in_a_vacuum("^>v<");
    assert_eq!(3, houses);
}

#[test]
fn test_perfectly_spherical_house_in_a_vacuum_6() {
    let (_, houses) = perfectly_spherical_house_in_a_vacuum("^v^v^v^v^v");
    assert_eq!(11, houses);
}