pub fn factors(value: Int) -> List(Int) {
  factor(value, 2, [])
}

fn factor(remaining: Int, candidate: Int, result: List(Int)) -> List(Int) {
  case remaining < 2 {
    True -> reverse(result, [])
    False ->
      case candidate * candidate > remaining {
        True -> [remaining, ..reverse(result, [])]
        False ->
          case remaining % candidate == 0 {
            True -> factor(remaining / candidate, candidate, [candidate, ..result])
            False -> factor(remaining, candidate + 1, result)
          }
      }
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
