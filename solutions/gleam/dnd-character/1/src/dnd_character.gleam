pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

import gleam/int
import gleam/list

pub fn generate_character() -> Character {
  let constitution = ability()

  Character(
    charisma: ability(),
    constitution: constitution,
    dexterity: ability(),
    hitpoints: 10 + modifier(constitution),
    intelligence: ability(),
    strength: ability(),
    wisdom: ability(),
  )
}

pub fn modifier(score: Int) -> Int {
  case score < 10 {
    True -> -((11 - score) / 2)
    False -> (score - 10) / 2
  }
}

pub fn ability() -> Int {
  let rolls = [
    int.random(1, 7),
    int.random(1, 7),
    int.random(1, 7),
    int.random(1, 7),
  ]
  let assert [_, first, second, third] = list.sort(rolls, by: int.compare)
  first + second + third
}
