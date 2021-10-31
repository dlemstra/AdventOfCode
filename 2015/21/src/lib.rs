#[derive(PartialEq)]
struct Item {
    cost: i32,
    damage: i32,
    armor: i32,
}

fn player_wins(start_hitpoints: i32, boss_damage: i32, boss_armor: i32, player_damage: i32, player_armor: i32) -> bool {
    let mut player_hitpoints = 100i32;
    let mut boss_hitpoints = start_hitpoints;

    while player_hitpoints > 0 && boss_hitpoints > 0 {
        boss_hitpoints -= player_damage - boss_armor;
        player_hitpoints -= boss_damage - player_armor;
    }

    return player_hitpoints > 0;
}

pub fn rpg_simulator_20xx(start_hitpoints: i32, boss_damage: i32, boss_armor: i32) -> i32 {
    let weapons = [
        Item{cost:  8, damage: 4, armor: 0},
        Item{cost: 10, damage: 5, armor: 0},
        Item{cost: 25, damage: 6, armor: 0},
        Item{cost: 40, damage: 7, armor: 0},
        Item{cost: 75, damage: 8, armor: 0}
    ];

    let armors = [
        Item{cost:  13, damage: 0, armor: 1},
        Item{cost:  31, damage: 0, armor: 2},
        Item{cost:  53, damage: 0, armor: 3},
        Item{cost:  76, damage: 0, armor: 4},
        Item{cost: 102, damage: 0, armor: 5}
    ];

    let rings = [
        Item{cost:  25, damage: 1, armor: 0},
        Item{cost:  50, damage: 2, armor: 0},
        Item{cost: 100, damage: 3, armor: 0},
        Item{cost:  20, damage: 0, armor: 1},
        Item{cost:  40, damage: 0, armor: 2},
        Item{cost:  80, damage: 0, armor: 3}
    ];

    let mut lowest_cost = i32::MAX;

    for weapon in weapons.iter() {
        for armor in armors.iter() {
            for ring in rings.iter() {
                let cost = armor.cost + weapon.cost + ring.cost;
                if cost < lowest_cost {
                    if player_wins(start_hitpoints, boss_damage, boss_armor, weapon.damage + ring.damage, armor.armor + ring.armor) {
                        lowest_cost = cost;
                    }
                }
            }

            for ring_a in rings.iter() {
                for ring_b in rings.iter() {
                    if ring_a.eq(ring_b) {
                        continue;
                    }

                    let cost = armor.cost + weapon.cost + ring_a.cost + ring_b.cost;
                    if cost < lowest_cost {
                        if player_wins(start_hitpoints, boss_damage, boss_armor, weapon.damage + ring_a.damage + ring_b.damage, armor.armor + ring_a.armor + ring_b.armor) {
                            lowest_cost = cost;
                        }
                    }
                }
            }

            let cost = armor.cost + weapon.cost;
            if cost < lowest_cost {
                if player_wins(start_hitpoints, boss_damage, boss_armor, weapon.damage, armor.armor) {
                    lowest_cost = cost;
                }
            }
        }
    }

    return lowest_cost;
}
