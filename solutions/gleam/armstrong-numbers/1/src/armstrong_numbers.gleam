import gleam/int
import gleam/list
import gleam/string

pub fn is_armstrong_number(number: Int) -> Bool {
  case number < 0 {
    True -> False
    False -> {
      let digits = number |> int.to_string |> string.to_graphemes
      digit_sum(digits, list.length(digits), 0) == number
    }
  }
}

fn digit_sum(digits: List(String), exponent: Int, total: Int) -> Int {
  case digits {
    [] -> total
    [digit, ..rest] ->
      case int.parse(digit) {
        Ok(value) -> digit_sum(rest, exponent, total + power(value, exponent))
        Error(_) -> digit_sum(rest, exponent, total)
      }
  }
}

fn power(base: Int, exponent: Int) -> Int {
  case exponent {
    0 -> 1
    _ -> base * power(base, exponent - 1)
  }
}
