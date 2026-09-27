pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  case input_base < 2 {
    True -> Error(InvalidBase(input_base))
    False ->
      case output_base < 2 {
        True -> Error(InvalidBase(output_base))
        False ->
          case validate_digits(digits, input_base) {
            Error(error) -> Error(error)
            Ok(_) -> {
              let decimal = to_decimal(digits, input_base, 0)
              Ok(to_output_base(decimal, output_base, []))
            }
          }
      }
  }
}

fn validate_digits(digits: List(Int), base: Int) -> Result(Nil, Error) {
  case digits {
    [] -> Ok(Nil)
    [digit, ..rest] ->
      case digit < 0 || digit >= base {
        True -> Error(InvalidDigit(digit))
        False -> validate_digits(rest, base)
      }
  }
}

fn to_decimal(digits: List(Int), base: Int, value: Int) -> Int {
  case digits {
    [] -> value
    [digit, ..rest] -> to_decimal(rest, base, value * base + digit)
  }
}

fn to_output_base(number: Int, base: Int, digits: List(Int)) -> List(Int) {
  case number {
    0 ->
      case digits {
        [] -> [0]
        _ -> digits
      }
    _ -> {
      to_output_base(number / base, base, [number % base, ..digits])
    }
  }
}
