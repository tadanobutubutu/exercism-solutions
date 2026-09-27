pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  sum_multiples(1, limit, factors, 0)
}

fn sum_multiples(candidate: Int, limit: Int, factors: List(Int), total: Int) -> Int {
  case candidate >= limit {
    True -> total
    False ->
      case is_multiple(candidate, factors) {
        True -> sum_multiples(candidate + 1, limit, factors, total + candidate)
        False -> sum_multiples(candidate + 1, limit, factors, total)
      }
  }
}

fn is_multiple(candidate: Int, factors: List(Int)) -> Bool {
  case factors {
    [] -> False
    [factor, ..rest] ->
      case factor != 0 && candidate % factor == 0 {
        True -> True
        False -> is_multiple(candidate, rest)
      }
  }
}
