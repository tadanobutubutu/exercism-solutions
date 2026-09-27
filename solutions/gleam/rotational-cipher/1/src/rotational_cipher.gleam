import gleam/list
import gleam/string

pub fn rotate(shift_key: Int, text: String) -> String {
  let key = shift_key % 26
  text
  |> string.to_graphemes
  |> rotate_chars(key, [])
  |> string.concat
}

fn rotate_chars(characters: List(String), key: Int, result: List(String)) -> List(String) {
  case characters {
    [] -> list.reverse(result)
    [character, ..rest] -> rotate_chars(rest, key, [rotate_character(character, key), ..result])
  }
}

fn rotate_character(character: String, key: Int) -> String {
  let lowercase = string.to_graphemes("abcdefghijklmnopqrstuvwxyz")
  let uppercase = string.to_graphemes("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  case find_index(lowercase, character, 0) {
    Some(index) -> at(lowercase, (index + key) % 26)
    None ->
      case find_index(uppercase, character, 0) {
        Some(index) -> at(uppercase, (index + key) % 26)
        None -> character
      }
  }
}

fn find_index(characters: List(String), target: String, index: Int) -> Option(Int) {
  case characters {
    [] -> None
    [character, ..rest] ->
      case character == target {
        True -> Some(index)
        False -> find_index(rest, target, index + 1)
      }
  }
}

fn at(characters: List(String), index: Int) -> String {
  case list.drop(characters, index) {
    [character, .._] -> character
    [] -> ""
  }
}
