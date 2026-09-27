pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number > 0 {
    True -> count_steps(number, 0)
    False -> Error(NonPositiveNumber)
  }
}

fn count_steps(number: Int, count: Int) -> Result(Int, Error) {
  case number {
    1 -> Ok(count)
    value if value % 2 == 0 -> count_steps(value / 2, count + 1)
    value -> count_steps(value * 3 + 1, count + 1)
  }
}
