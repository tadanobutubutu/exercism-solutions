pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

pub fn score(category: Category, dice: List(Int)) -> Int {
  case category {
    Ones -> count(dice, 1)
    Twos -> count(dice, 2) * 2
    Threes -> count(dice, 3) * 3
    Fours -> count(dice, 4) * 4
    Fives -> count(dice, 5) * 5
    Sixes -> count(dice, 6) * 6
    FullHouse ->
      case any_with_count(dice, 1, 2) && any_with_count(dice, 1, 3) {
        True -> sum(dice)
        False -> 0
      }
    FourOfAKind -> four_kind_score(dice, 1)
    LittleStraight ->
      case has_all(dice, [1, 2, 3, 4, 5]) {
        True -> 30
        False -> 0
      }
    BigStraight ->
      case has_all(dice, [2, 3, 4, 5, 6]) {
        True -> 30
        False -> 0
      }
    Choice -> sum(dice)
    Yacht ->
      case dice {
        [first, .._] ->
          case count(dice, first) == 5 {
            True -> 50
            False -> 0
          }
        [] -> 0
      }
  }
}

fn count(dice: List(Int), value: Int) -> Int {
  case dice {
    [] -> 0
    [die, ..rest] ->
      case die == value {
        True -> 1 + count(rest, value)
        False -> count(rest, value)
      }
  }
}

fn sum(dice: List(Int)) -> Int {
  case dice {
    [] -> 0
    [die, ..rest] -> die + sum(rest)
  }
}

fn any_with_count(dice: List(Int), value: Int, expected: Int) -> Bool {
  case value > 6 {
    True -> False
    False -> count(dice, value) == expected || any_with_count(dice, value + 1, expected)
  }
}

fn four_kind_score(dice: List(Int), value: Int) -> Int {
  case value > 6 {
    True -> 0
    False ->
      case count(dice, value) >= 4 {
        True -> value * 4
        False -> four_kind_score(dice, value + 1)
      }
  }
}

fn has_all(dice: List(Int), values: List(Int)) -> Bool {
  case values {
    [] -> True
    [value, ..rest] -> contains(dice, value) && has_all(dice, rest)
  }
}

fn contains(dice: List(Int), value: Int) -> Bool {
  case dice {
    [] -> False
    [die, ..rest] ->
      case die == value {
        True -> True
        False -> contains(rest, value)
      }
  }
}
