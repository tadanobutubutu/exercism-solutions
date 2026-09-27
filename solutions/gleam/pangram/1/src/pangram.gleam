import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let letters =
    sentence
    |> string.to_graphemes
    |> collect_letters(set.new())

  list.all(alphabet(), fn(letter) { set.contains(letters, letter) })
}

fn collect_letters(characters: List(String), found: Set(String)) -> Set(String) {
  case characters {
    [] -> found
    [character, ..rest] -> {
      let lower = string.lowercase(character)
      let found = case lower != string.uppercase(character) {
        True -> set.insert(found, lower)
        False -> found
      }
      collect_letters(rest, found)
    }
  }
}

fn alphabet() -> List(String) {
  [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  ]
}
