import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 -> {
      let mana = case player.level >= 10 {
        True -> Some(100)
        False -> player.mana
      }
      Some(Player(..player, health: 100, mana: mana))
    }
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) if mana >= cost ->
      #(Player(..player, mana: Some(mana - cost)), cost * 2)
    Some(_) -> #(player, 0)
    None -> {
      let remaining_health = player.health - cost
      let health = case remaining_health {
        value if value > 0 -> value
        _ -> 0
      }
      #(Player(..player, health: health), 0)
    }
  }
}
