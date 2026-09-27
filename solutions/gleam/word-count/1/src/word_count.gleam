import gleam/dict.{type Dict}
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  count(string.to_graphemes(string.lowercase(input)), "", dict.new())
}

fn count(characters: List(String), current: String, words: Dict(String, Int)) -> Dict(String, Int) {
  case characters {
    [] -> add_word(words, current)
    [character, ..rest] ->
      case is_alphanumeric(character) {
        True -> count(rest, current <> character, words)
        False ->
          case character == "'" && current != "" && next_is_alphanumeric(rest) {
            True -> count(rest, current <> character, words)
            False -> count(rest, "", add_word(words, current))
          }
      }
  }
}

fn add_word(words: Dict(String, Int), word: String) -> Dict(String, Int) {
  case word {
    "" -> words
    _ ->
      case dict.get(words, word) {
        Ok(count) -> dict.insert(words, word, count + 1)
        Error(_) -> dict.insert(words, word, 1)
      }
  }
}

fn next_is_alphanumeric(characters: List(String)) -> Bool {
  case characters {
    [] -> False
    [character, .._] -> is_alphanumeric(character)
  }
}

fn is_alphanumeric(character: String) -> Bool {
  is_digit(character) || contains_letter(string.to_graphemes("abcdefghijklmnopqrstuvwxyz"), character)
}

fn is_digit(character: String) -> Bool {
  case character {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}

fn contains_letter(letters: List(String), character: String) -> Bool {
  case letters {
    [] -> False
    [letter, ..rest] ->
      case letter == character {
        True -> True
        False -> contains_letter(rest, character)
      }
  }
}
