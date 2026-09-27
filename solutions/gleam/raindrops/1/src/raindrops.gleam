import gleam/int

pub fn convert(number: Int) -> String {
  let result =
    (if_divisible(number, 3, "Pling")
      <> if_divisible(number, 5, "Plang"))
    <> if_divisible(number, 7, "Plong")

  case result {
    "" -> int.to_string(number)
    _ -> result
  }
}

fn if_divisible(number: Int, divisor: Int, sound: String) -> String {
  case number % divisor == 0 {
    True -> sound
    False -> ""
  }
}
