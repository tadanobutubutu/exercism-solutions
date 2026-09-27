pub fn convert(number: Int) -> String {
  encode(number, [
    #(1000, "M"),
    #(900, "CM"),
    #(500, "D"),
    #(400, "CD"),
    #(100, "C"),
    #(90, "XC"),
    #(50, "L"),
    #(40, "XL"),
    #(10, "X"),
    #(9, "IX"),
    #(5, "V"),
    #(4, "IV"),
    #(1, "I"),
  ], "")
}

fn encode(number: Int, values: List(#(Int, String)), result: String) -> String {
  case values {
    [] -> result
    [#(value, numeral), ..rest] ->
      case number >= value {
        True -> encode(number - value, values, result <> numeral)
        False -> encode(number, rest, result)
      }
  }
}
