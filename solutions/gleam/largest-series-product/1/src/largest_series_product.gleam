import gleam/int
import gleam/list
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  let digits = string.to_graphemes(digits)
  case span < 0 || span > list.length(digits) {
    True -> Error(Nil)
    False if span == 0 -> Ok(1)
    False -> largest_window(digits, span, 0)
  }
}

fn largest_window(digits: List(String), span: Int, best: Int) -> Result(Int, Nil) {
  let window = list.take(digits, span)
  case list.length(window) == span {
    False -> Ok(best)
    True ->
      case product(window, 1) {
        Ok(value) -> {
          let best = case value > best {
            True -> value
            False -> best
          }
          largest_window(list.drop(digits, 1), span, best)
        }
        Error(Nil) -> Error(Nil)
      }
  }
}

fn product(digits: List(String), value: Int) -> Result(Int, Nil) {
  case digits {
    [] -> Ok(value)
    [digit, ..rest] ->
      case int.parse(digit) {
        Ok(parsed) -> product(rest, value * parsed)
        Error(_) -> Error(Nil)
      }
  }
}
