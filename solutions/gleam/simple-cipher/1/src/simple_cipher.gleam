import gleam/int
import gleam/list
import gleam/string

pub fn encode(plaintext plaintext: String, key key: String) -> String {
  transform(plaintext, key, False)
}

pub fn decode(ciphertext ciphertext: String, key key: String) -> String {
  transform(ciphertext, key, True)
}

pub fn generate_key() -> String {
  random_key(100, "")
}

fn transform(text: String, key: String, decoding: Bool) -> String {
  let key_letters = string.to_graphemes(key)
  case key_letters {
    [] -> text
    _ -> transform_letters(string.to_graphemes(text), key_letters, 0, decoding, "")
  }
}

fn transform_letters(
  text: List(String),
  key: List(String),
  key_index: Int,
  decoding: Bool,
  result: String,
) -> String {
  case text {
    [] -> result
    [letter, ..rest] -> {
      let shift = letter_index(at(key, key_index))
      let index = letter_index(letter)
      let rotated =
        case decoding {
          True -> at(alphabet(), (index - shift + 26) % 26)
          False -> at(alphabet(), (index + shift) % 26)
        }
      let next_index =
        case key_index + 1 >= list.length(key) {
          True -> 0
          False -> key_index + 1
        }
      transform_letters(rest, key, next_index, decoding, result <> rotated)
    }
  }
}

fn random_key(remaining: Int, result: String) -> String {
  case remaining <= 0 {
    True -> result
    False -> {
      let letter = at(alphabet(), int.random(0, 26))
      random_key(remaining - 1, result <> letter)
    }
  }
}

fn alphabet() -> List(String) {
  string.to_graphemes("abcdefghijklmnopqrstuvwxyz")
}

fn letter_index(letter: String) -> Int {
  find_index(alphabet(), letter, 0)
}

fn find_index(letters: List(String), target: String, index: Int) -> Int {
  case letters {
    [] -> 0
    [letter, ..rest] ->
      case letter == target {
        True -> index
        False -> find_index(rest, target, index + 1)
      }
  }
}

fn at(letters: List(String), index: Int) -> String {
  case list.drop(letters, index) {
    [letter, .._] -> letter
    [] -> "a"
  }
}
