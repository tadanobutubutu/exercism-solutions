pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  recite_verses(start_bottles, take_down, "")
}

fn recite_verses(current: Int, remaining: Int, result: String) -> String {
  case remaining <= 0 {
    True -> result
    False -> {
      let verse = verse(current)
      let updated =
        case result {
          "" -> verse
          _ -> result <> "\n\n" <> verse
        }
      recite_verses(current - 1, remaining - 1, updated)
    }
  }
}

fn verse(bottles: Int) -> String {
  let subject = title_number(bottles) <> " green bottle" <> plural(bottles)
  let fallen = lower_number(bottles - 1) <> " green bottle" <> plural(bottles - 1)

  subject
  <> " hanging on the wall,\n"
  <> subject
  <> " hanging on the wall,\n"
  <> "And if one green bottle should accidentally fall,\n"
  <> "There'll be "
  <> fallen
  <> " hanging on the wall."
}

fn plural(bottles: Int) -> String {
  case bottles == 1 {
    True -> ""
    False -> "s"
  }
}

fn title_number(number: Int) -> String {
  case number {
    0 -> "Zero"
    1 -> "One"
    2 -> "Two"
    3 -> "Three"
    4 -> "Four"
    5 -> "Five"
    6 -> "Six"
    7 -> "Seven"
    8 -> "Eight"
    9 -> "Nine"
    10 -> "Ten"
    _ -> ""
  }
}

fn lower_number(number: Int) -> String {
  case number {
    0 -> "no"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    _ -> ""
  }
}
