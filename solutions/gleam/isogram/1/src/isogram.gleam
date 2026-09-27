import gleam/set.{type Set}
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  check_letters(string.to_graphemes(phrase), set.new())
}

fn check_letters(letters: List(String), seen: Set(String)) -> Bool {
  case letters {
    [] -> True
    [letter, ..rest] -> {
      let normalized = string.lowercase(letter)
      case string.lowercase(letter) != string.uppercase(letter) {
        False -> check_letters(rest, seen)
        True ->
          case set.contains(seen, normalized) {
            True -> False
            False -> check_letters(rest, set.insert(seen, normalized))
          }
      }
    }
  }
}
