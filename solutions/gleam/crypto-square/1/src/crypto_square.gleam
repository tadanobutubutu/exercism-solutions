import gleam/list
import gleam/string

pub fn ciphertext(plaintext: String) -> String {
  let characters = plaintext |> string.lowercase |> string.to_graphemes |> normalize([])
  let length = list.length(characters)
  case length {
    0 -> ""
    _ -> {
      let #(rows, columns) = dimensions(length, 1)
      encode_columns(characters, rows, columns, 0, "")
    }
  }
}

fn normalize(characters: List(String), result: List(String)) -> List(String) {
  case characters {
    [] -> reverse(result, [])
    [character, ..rest] ->
      case is_alphanumeric(character) {
        True -> normalize(rest, [character, ..result])
        False -> normalize(rest, result)
      }
  }
}

fn is_alphanumeric(character: String) -> Bool {
  is_digit(character) || contains(string.to_graphemes("abcdefghijklmnopqrstuvwxyz"), character)
}

fn is_digit(character: String) -> Bool {
  case character {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}

fn contains(characters: List(String), target: String) -> Bool {
  case characters {
    [] -> False
    [character, ..rest] -> character == target || contains(rest, target)
  }
}

fn dimensions(length: Int, columns: Int) -> #(Int, Int) {
  let rows = (length + columns - 1) / columns
  case columns >= rows && columns - rows <= 1 {
    True -> #(rows, columns)
    False -> dimensions(length, columns + 1)
  }
}

fn encode_columns(
  characters: List(String),
  rows: Int,
  columns: Int,
  column: Int,
  result: String,
) -> String {
  case column >= columns {
    True -> result
    False -> {
      let encoded = column_text(characters, rows, columns, column, 0, "")
      let updated =
        case column {
          0 -> encoded
          _ -> result <> " " <> encoded
        }
      encode_columns(characters, rows, columns, column + 1, updated)
    }
  }
}

fn column_text(
  characters: List(String),
  rows: Int,
  columns: Int,
  column: Int,
  row: Int,
  result: String,
) -> String {
  case row >= rows {
    True -> result
    False -> {
      let index = row * columns + column
      let character =
        case list.drop(characters, index) {
          [] -> " "
          [first, .._] -> first
        }
      column_text(characters, rows, columns, column, row + 1, result <> character)
    }
  }
}

fn reverse(values: List(String), result: List(String)) -> List(String) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
