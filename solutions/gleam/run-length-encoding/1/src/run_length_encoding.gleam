import gleam/int
import gleam/string

pub fn encode(plaintext: String) -> String {
  encode_chars(string.to_graphemes(plaintext), "")
}

pub fn decode(ciphertext: String) -> String {
  decode_chars(string.to_graphemes(ciphertext), "", "", "")
}

fn encode_chars(characters: List(String), result: String) -> String {
  case characters {
    [] -> result
    [character, ..rest] -> encode_run(rest, character, 1, result)
  }
}

fn encode_run(
  remaining: List(String),
  character: String,
  count: Int,
  result: String,
) -> String {
  case remaining {
    [next, ..rest] if next == character -> encode_run(rest, character, count + 1, result)
    _ -> {
      let encoded =
        case count {
          1 -> character
          _ -> int.to_string(count) <> character
        }
      encode_chars(remaining, result <> encoded)
    }
  }
}

fn decode_chars(
  characters: List(String),
  count_text: String,
  result: String,
  _unused: String,
) -> String {
  case characters {
    [] -> result
    [character, ..rest] ->
      case is_digit(character) {
        True -> decode_chars(rest, count_text <> character, result, "")
        False -> {
          let count =
            case count_text {
              "" -> 1
              _ ->
                case int.parse(count_text) {
                  Ok(value) -> value
                  Error(_) -> 1
                }
            }
          decode_chars(rest, "", result <> repeat(character, count, ""), "")
        }
      }
  }
}

fn is_digit(character: String) -> Bool {
  case character {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}

fn repeat(character: String, count: Int, result: String) -> String {
  case count <= 0 {
    True -> result
    False -> repeat(character, count - 1, result <> character)
  }
}
