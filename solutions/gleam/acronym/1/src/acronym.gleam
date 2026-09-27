import gleam/list
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  abbreviate_chars(string.to_graphemes(phrase), False, [])
  |> list.reverse
  |> string.concat
}

fn abbreviate_chars(
  characters: List(String),
  in_word: Bool,
  result: List(String),
) -> List(String) {
  case characters {
    [] -> result
    [character, ..rest] -> case is_letter(character) {
      True -> case in_word {
        True -> abbreviate_chars(rest, True, result)
        False -> abbreviate_chars(rest, True, [string.uppercase(character), ..result])
      }
      False -> case character == "'" && in_word {
        True -> abbreviate_chars(rest, True, result)
        False -> abbreviate_chars(rest, False, result)
      }
    }
  }
}

fn is_letter(character: String) -> Bool {
  let lowercase = string.lowercase(character)
  (lowercase >= "a" && lowercase <= "z") || string.uppercase(character) != lowercase
}
