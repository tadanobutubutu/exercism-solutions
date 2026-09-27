pub fn prime(number: Int) -> Result(Int, Nil) {
  case number > 0 {
    False -> Error(Nil)
    True -> nth_prime(number, 2, 0)
  }
}

fn nth_prime(target: Int, candidate: Int, count: Int) -> Result(Int, Nil) {
  case is_prime(candidate, 2) {
    True if count + 1 == target -> Ok(candidate)
    True -> nth_prime(target, candidate + 1, count + 1)
    False -> nth_prime(target, candidate + 1, count)
  }
}

fn is_prime(number: Int, divisor: Int) -> Bool {
  case number < 2 {
    True -> False
    False if divisor * divisor > number -> True
    False if number % divisor == 0 -> False
    False -> is_prime(number, divisor + 1)
  }
}
