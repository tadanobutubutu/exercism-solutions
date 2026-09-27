import gleam/string

pub fn encode(phrase: String) -> String {
  encode_chars(string.to_graphemes(string.lowercase(phrase)), "", 0, "")
}

pub fn decode(phrase: String) -> String {
  decode_chars(string.to_graphemes(string.lowercase(phrase)), "")
}

fn encode_chars(chars: List(String), group: String, count: Int, result: String) -> String {
  case chars {
    [] -> append_group(result, group)
    [char, ..rest] ->
      case substitute(char) {
        Some(encoded) ->
          case count == 5 {
            True -> encode_chars(rest, encoded, 1, append_group(result, group))
            False -> encode_chars(rest, group <> encoded, count + 1, result)
          }
        None -> encode_chars(rest, group, count, result)
      }
  }
}

fn decode_chars(chars: List(String), result: String) -> String {
  case chars {
    [] -> result
    [char, ..rest] ->
      case substitute(char) {
        Some(decoded) -> decode_chars(rest, result <> decoded)
        None -> decode_chars(rest, result)
      }
  }
}

fn append_group(result: String, group: String) -> String {
  case group {
    "" -> result
    _ ->
      case result {
        "" -> group
        _ -> result <> " " <> group
      }
  }
}

fn substitute(char: String) -> Option(String) {
  case char {
    "a" -> Some("z")
    "b" -> Some("y")
    "c" -> Some("x")
    "d" -> Some("w")
    "e" -> Some("v")
    "f" -> Some("u")
    "g" -> Some("t")
    "h" -> Some("s")
    "i" -> Some("r")
    "j" -> Some("q")
    "k" -> Some("p")
    "l" -> Some("o")
    "m" -> Some("n")
    "n" -> Some("m")
    "o" -> Some("l")
    "p" -> Some("k")
    "q" -> Some("j")
    "r" -> Some("i")
    "s" -> Some("h")
    "t" -> Some("g")
    "u" -> Some("f")
    "v" -> Some("e")
    "w" -> Some("d")
    "x" -> Some("c")
    "y" -> Some("b")
    "z" -> Some("a")
    "0" -> Some("0")
    "1" -> Some("1")
    "2" -> Some("2")
    "3" -> Some("3")
    "4" -> Some("4")
    "5" -> Some("5")
    "6" -> Some("6")
    "7" -> Some("7")
    "8" -> Some("8")
    "9" -> Some("9")
    _ -> None
  }
}
