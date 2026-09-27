import gleam/list

const gifts = [
  "a Partridge in a Pear Tree",
  "two Turtle Doves",
  "three French Hens",
  "four Calling Birds",
  "five Gold Rings",
  "six Geese-a-Laying",
  "seven Swans-a-Swimming",
  "eight Maids-a-Milking",
  "nine Ladies Dancing",
  "ten Lords-a-Leaping",
  "eleven Pipers Piping",
  "twelve Drummers Drumming",
]

pub fn verse(number: Int) -> String {
  let day = ordinal(number)
  let gifts_for_day = gifts |> list.take(number) |> list.reverse
  let gift_line = case number {
    1 -> "a Partridge in a Pear Tree"
    _ ->
      let other_gifts = list.take(gifts_for_day, number - 1)
      join_with_commas(other_gifts) <> ", and a Partridge in a Pear Tree"
  }

  "On the " <> day <> " day of Christmas my true love gave to me: " <> gift_line <> "."
}

pub fn lyrics(from starting_verse: Int, to ending_verse: Int) -> String {
  collect_verses(starting_verse, ending_verse)
}

fn collect_verses(current: Int, ending: Int) -> String {
  case current > ending {
    True -> ""
    False if current == ending -> verse(current)
    False -> verse(current) <> "\n\n" <> collect_verses(current + 1, ending)
  }
}

fn ordinal(number: Int) -> String {
  case number {
    1 -> "first"
    2 -> "second"
    3 -> "third"
    4 -> "fourth"
    5 -> "fifth"
    6 -> "sixth"
    7 -> "seventh"
    8 -> "eighth"
    9 -> "ninth"
    10 -> "tenth"
    11 -> "eleventh"
    12 -> "twelfth"
    _ -> ""
  }
}

fn join_with_commas(items: List(String)) -> String {
  case items {
    [] -> ""
    [item] -> item
    [item, ..rest] -> item <> ", " <> join_with_commas(rest)
  }
}
