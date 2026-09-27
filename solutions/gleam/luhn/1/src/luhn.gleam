import gleam/list
import gleam/string

pub fn valid(value: String) -> Bool {
  let characters = string.to_graphemes(value)
  case digits(characters, []) {
    Error(_) -> False
    Ok(values) ->
      case list.length(values) > 1 {
        True -> checksum(reverse(values, []), 0, 0) % 10 == 0
        False -> False
      }
  }
}

fn digits(characters: List(String), result: List(Int)) -> Result(List(Int), Nil) {
  case characters {
    [] -> Ok(reverse_ints(result, []))
    [character, ..rest] ->
      case character {
        " " -> digits(rest, result)
        _ ->
          case int.parse(character) {
            Ok(value) -> digits(rest, [value, ..result])
            Error(_) -> Error(Nil)
          }
      }
  }
}

fn checksum(values: List(Int), index: Int, total: Int) -> Int {
  case values {
    [] -> total
    [value, ..rest] -> {
      let updated =
        case index % 2 {
          0 -> value
          _ -> {
            let doubled = value * 2
            case doubled > 9 {
              True -> doubled - 9
              False -> doubled
            }
          }
        }
      checksum(rest, index + 1, total + updated)
    }
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}

fn reverse_ints(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_ints(rest, [value, ..result])
  }
}
