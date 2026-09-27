pub type Error {
  OutOfRange
}

pub fn say(number: Int) -> Result(String, Error) {
  case number < 0 || number > 999_999_999_999 {
    True -> Error(OutOfRange)
    False ->
      case number {
        0 -> Ok("zero")
        _ -> Ok(number_words(number))
      }
  }
}

fn number_words(number: Int) -> String {
  let billions = number / 1_000_000_000
  let millions = number / 1_000_000 % 1000
  let thousands = number / 1000 % 1000
  let remainder = number % 1000

  ""
  |> add_part(billions, "billion")
  |> add_part(millions, "million")
  |> add_part(thousands, "thousand")
  |> add_part(remainder, "")
}

fn add_part(result: String, value: Int, scale: String) -> String {
  case value == 0 {
    True -> result
    False -> {
      let words = under_thousand(value)
      let part =
        case scale {
          "" -> words
          _ -> words <> " " <> scale
        }
      case result {
        "" -> part
        _ -> result <> " " <> part
      }
    }
  }
}

fn under_thousand(number: Int) -> String {
  case number >= 100 {
    True -> {
      let hundreds = under_twenty(number / 100) <> " hundred"
      let remainder = number % 100
      case remainder {
        0 -> hundreds
        _ -> hundreds <> " " <> under_hundred(remainder)
      }
    }
    False -> under_hundred(number)
  }
}

fn under_hundred(number: Int) -> String {
  case number >= 20 {
    True -> {
      let tens = tens_word(number / 10)
      case number % 10 {
        0 -> tens
        remainder -> tens <> "-" <> under_twenty(remainder)
      }
    }
    False -> under_twenty(number)
  }
}

fn under_twenty(number: Int) -> String {
  case number {
    0 -> "zero"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    11 -> "eleven"
    12 -> "twelve"
    13 -> "thirteen"
    14 -> "fourteen"
    15 -> "fifteen"
    16 -> "sixteen"
    17 -> "seventeen"
    18 -> "eighteen"
    19 -> "nineteen"
    _ -> ""
  }
}

fn tens_word(number: Int) -> String {
  case number {
    2 -> "twenty"
    3 -> "thirty"
    4 -> "forty"
    5 -> "fifty"
    6 -> "sixty"
    7 -> "seventy"
    8 -> "eighty"
    9 -> "ninety"
    _ -> ""
  }
}
