pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number > 0 {
    False -> Error(NonPositiveInt)
    True -> {
      let sum = aliquot_sum(number, 1, 0)
      case sum {
        value if value == number -> Ok(Perfect)
        value if value > number -> Ok(Abundant)
        _ -> Ok(Deficient)
      }
    }
  }
}

fn aliquot_sum(number: Int, divisor: Int, sum: Int) -> Int {
  case divisor > number / 2 {
    True -> sum
    False if number % divisor == 0 ->
      aliquot_sum(number, divisor + 1, sum + divisor)
    False -> aliquot_sum(number, divisor + 1, sum)
  }
}
