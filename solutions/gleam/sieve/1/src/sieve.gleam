pub fn primes_up_to(upper_bound: Int) -> List(Int) {
  collect_primes(2, upper_bound, [])
}

fn collect_primes(candidate: Int, upper_bound: Int, result: List(Int)) -> List(Int) {
  case candidate > upper_bound {
    True -> reverse(result, [])
    False ->
      case is_prime(candidate, 2) {
        True -> collect_primes(candidate + 1, upper_bound, [candidate, ..result])
        False -> collect_primes(candidate + 1, upper_bound, result)
      }
  }
}

fn is_prime(value: Int, divisor: Int) -> Bool {
  case divisor * divisor > value {
    True -> True
    False ->
      case value % divisor == 0 {
        True -> False
        False -> is_prime(value, divisor + 1)
      }
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
