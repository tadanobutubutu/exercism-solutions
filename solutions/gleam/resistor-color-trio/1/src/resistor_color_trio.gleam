pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  case colors {
    [first, second, third, ..] ->
      case #(color_value(first), color_value(second), color_value(third)) {
        #(Ok(first_value), Ok(second_value), Ok(zeros)) -> {
          let base = first_value * 10 + second_value
          let unit_and_power = case zeros {
            value if value < 3 -> #("ohms", value)
            value if value < 6 -> #("kiloohms", value - 3)
            value if value < 9 -> #("megaohms", value - 6)
            _ -> #("gigaohms", zeros - 9)
          }
          let #(unit, power) = unit_and_power
          Ok(Resistance(unit: unit, value: base * power_of_ten(power)))
        }
        _ -> Error(Nil)
      }
    _ -> Error(Nil)
  }
}

fn color_value(color: String) -> Result(Int, Nil) {
  case color {
    "black" -> Ok(0)
    "brown" -> Ok(1)
    "red" -> Ok(2)
    "orange" -> Ok(3)
    "yellow" -> Ok(4)
    "green" -> Ok(5)
    "blue" -> Ok(6)
    "violet" -> Ok(7)
    "grey" -> Ok(8)
    "white" -> Ok(9)
    _ -> Error(Nil)
  }
}

fn power_of_ten(power: Int) -> Int {
  case power {
    0 -> 1
    _ -> 10 * power_of_ten(power - 1)
  }
}
