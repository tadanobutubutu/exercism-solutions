import gleam/list
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  case digits_from(string.to_graphemes(input), []) {
    Error(error) -> Error(error)
    Ok(digits) -> validate(digits)
  }
}

fn digits_from(characters: List(String), digits: List(String)) -> Result(List(String), String) {
  case characters {
    [] -> Ok(reverse(digits, []))
    [character, ..rest] ->
      case digit(character) {
        True -> digits_from(rest, [character, ..digits])
        False ->
          case character {
            " " | "-" | "(" | ")" | "." | "+" -> digits_from(rest, digits)
            _ ->
              case is_letter(character) {
                True -> Error("letters not permitted")
                False -> Error("punctuations not permitted")
              }
          }
      }
  }
}

fn validate(digits: List(String)) -> Result(String, String) {
  case list.length(digits) {
    count if count < 10 -> Error("must not be fewer than 10 digits")
    count if count > 11 -> Error("must not be greater than 11 digits")
    11 ->
      case digits {
        ["1", ..rest] -> validate_ten(rest)
        _ -> Error("11 digits must start with 1")
      }
    _ -> validate_ten(digits)
  }
}

fn validate_ten(digits: List(String)) -> Result(String, String) {
  case digits {
    [area, _, _, exchange, _, _, _, _, _, _] ->
      case area {
        "0" -> Error("area code cannot start with zero")
        "1" -> Error("area code cannot start with one")
        _ ->
          case exchange {
            "0" -> Error("exchange code cannot start with zero")
            "1" -> Error("exchange code cannot start with one")
            _ -> Ok(string.concat(digits))
          }
      }
    _ -> Error("must not be fewer than 10 digits")
  }
}

fn digit(character: String) -> Bool {
  case character {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}

fn is_letter(character: String) -> Bool {
  contains(string.to_graphemes("abcdefghijklmnopqrstuvwxyz"), string.lowercase(character))
}

fn contains(characters: List(String), character: String) -> Bool {
  case characters {
    [] -> False
    [first, ..rest] ->
      case first == character {
        True -> True
        False -> contains(rest, character)
      }
  }
}

fn reverse(values: List(String), result: List(String)) -> List(String) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
