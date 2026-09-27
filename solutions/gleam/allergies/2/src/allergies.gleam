pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  score / value(allergen) % 2 == 1
}

pub fn list(score: Int) -> List(Allergen) {
  collect(
    [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats],
    score,
    [],
  )
  |> reverse_allergens
}

fn value(allergen: Allergen) -> Int {
  case allergen {
    Eggs -> 1
    Peanuts -> 2
    Shellfish -> 4
    Strawberries -> 8
    Tomatoes -> 16
    Chocolate -> 32
    Pollen -> 64
    Cats -> 128
  }
}

fn collect(allergens: List(Allergen), score: Int, found: List(Allergen)) -> List(Allergen) {
  case allergens {
    [] -> found
    [allergen, ..rest] ->
      case allergic_to(allergen, score) {
        True -> collect(rest, score, [allergen, ..found])
        False -> collect(rest, score, found)
      }
  }
}

fn reverse_allergens(allergens: List(Allergen)) -> List(Allergen) {
  reverse(allergens, [])
}

fn reverse(allergens: List(Allergen), result: List(Allergen)) -> List(Allergen) {
  case allergens {
    [] -> result
    [allergen, ..rest] -> reverse(rest, [allergen, ..result])
  }
}
