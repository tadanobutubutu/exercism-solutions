import gleam/string

pub fn is_valid(isbn: String) -> Bool {
  let characters =
    isbn
    |> string.to_graphemes
    |> remove_dashes([])

  case characters {
    [a, b, c, d, e, f, g, h, i, check] ->
      case sum_weighted([a, b, c, d, e, f, g, h, i], 10, 0) {
        None -> False
        Some(sum) ->
          case check_value(check) {
            None -> False
            Some(value) -> (sum + value) % 11 == 0
          }
      }
    _ -> False
  }
}

fn remove_dashes(characters: List(String), result: List(String)) -> List(String) {
  case characters {
    [] -> reverse(result, [])
    [character, ..rest] ->
      case character {
        "-" -> remove_dashes(rest, result)
        _ -> remove_dashes(rest, [character, ..result])
      }
  }
}

fn sum_weighted(
  digits: List(String),
  weight: Int,
  total: Int,
) -> Option(Int) {
  case digits {
    [] -> Some(total)
    [digit, ..rest] ->
      case digit_value(digit) {
        None -> None
        Some(value) -> sum_weighted(rest, weight - 1, total + value * weight)
      }
  }
}

fn check_value(character: String) -> Option(Int) {
  case character {
    "X" -> Some(10)
    _ -> digit_value(character)
  }
}

fn digit_value(character: String) -> Option(Int) {
  case character {
    "0" -> Some(0)
    "1" -> Some(1)
    "2" -> Some(2)
    "3" -> Some(3)
    "4" -> Some(4)
    "5" -> Some(5)
    "6" -> Some(6)
    "7" -> Some(7)
    "8" -> Some(8)
    "9" -> Some(9)
    _ -> None
  }
}

fn reverse(characters: List(String), result: List(String)) -> List(String) {
  case characters {
    [] -> result
    [character, ..rest] -> reverse(rest, [character, ..result])
  }
}
