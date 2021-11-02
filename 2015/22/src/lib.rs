#[derive(Copy,Clone)]
struct Item {
    id: i32,
    cost: i32,
    damage: i32,
    armor: i32,
    heal: i32,
    mana: i32,
    duration: i32
}

#[derive(Copy,Clone)]
struct Boss {
    hitpoints: i32,
    damage: i32
}

#[derive(Copy,Clone)]
struct Player {
    hitpoints: i32,
    mana: i32
}

struct State {
    player: Player,
    boss: Boss,
    mana_used: i32,
    effects: Vec<Item>
}

impl State {
    fn clone(&self) -> State {
        return State{player: self.player, boss: self.boss, mana_used: self.mana_used, effects: self.effects.to_vec()};
    }

    fn play_round(&mut self, item: &Item, hard_mode: bool) -> bool {
        if hard_mode {
            self.player.hitpoints -= 1;
            if self.player.hitpoints == 0 {
                return false;
            }
        }

        self.apply_affects();
        if self.boss.hitpoints <= 0 {
            return false;
        }

        if self.cast_spell(item) == false {
            return false;
        }

        self.apply_affects();
        if self.boss.hitpoints <= 0 {
            return false;
        }

        self.attack_player();

        return self.player.hitpoints > 0;
    }

    fn apply_affects(&mut self) {
        let mut new_effects = Vec::new();
        for effect in &self.effects {
            let mut new_effect = effect.clone();
            new_effect.duration -= 1;

            self.player.mana += effect.mana;
            self.boss.hitpoints -= effect.damage;

            if new_effect.duration > 0 {
                new_effects.push(new_effect);
            }
        }
        self.effects = new_effects;
    }

    fn cast_spell(&mut self, item: &Item) -> bool {
        if self.player.mana < item.cost {
            return false;
        }

        for effect in &self.effects {
            if effect.id == item.id {
                return false;
            }
        }

        self.mana_used += item.cost;
        self.player.mana -= item.cost;

        if item.duration > 1 {
            self.effects.push(*item);
        } else {
            self.player.hitpoints += item.heal;
            self.boss.hitpoints -= item.damage;
        }

        return self.boss.hitpoints > 0;
    }

    fn attack_player(&mut self) {
        let armor = self.effects.iter().map(|x|x.armor).sum::<i32>();
        self.player.hitpoints -= self.boss.damage - armor;
    }
}

fn play_game(boss_hitpoints: i32, boss_damage: i32, hard_mode: bool) -> i32 {
    let items = [
        Item{id: 0, cost:  53, damage: 4, armor: 0, heal: 0, mana:   0, duration: 1},
        Item{id: 1, cost:  73, damage: 2, armor: 0, heal: 2, mana:   0, duration: 1},
        Item{id: 2, cost: 113, damage: 0, armor: 7, heal: 0, mana:   0, duration: 6},
        Item{id: 3, cost: 173, damage: 3, armor: 0, heal: 0, mana:   0, duration: 6},
        Item{id: 4, cost: 229, damage: 0, armor: 0, heal: 0, mana: 101, duration: 5},
    ];

    let mut states: Vec<State> = Vec::new();

    states.push(State{
        player: Player{hitpoints: 50, mana: 500},
        boss: Boss{hitpoints: boss_hitpoints, damage: boss_damage},
        mana_used: 0,
        effects: Vec::new()
    });

    let mut best_mana = i32::MAX;

    while states.len() > 0 {
        if let Some(state) = states.pop() {
            if state.mana_used >= best_mana {
                continue;
            }

            for item in items.iter() {
                let mut new_state = state.clone();

                if !new_state.play_round(&item, hard_mode) {
                    if new_state.player.hitpoints > 0 && new_state.boss.hitpoints <= 0 {
                        if new_state.mana_used < best_mana {
                            best_mana = new_state.mana_used;
                        }
                    }
                }
                else {
                    states.push(new_state);
                }
            }
        }
    }

    return best_mana;
}

pub fn wizard_simulator_20xx(boss_hitpoints: i32, boss_damage: i32) -> (i32, i32) {
    let part1 = play_game(boss_hitpoints, boss_damage, false);
    let part2 = play_game(boss_hitpoints, boss_damage, true);

    return (part1, part2);
}
