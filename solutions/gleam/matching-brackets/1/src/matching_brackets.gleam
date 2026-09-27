import gleam/string

pub fn is_paired(value: String) -> Bool {
  check(string.to_graphemes(value), [])
}

fn check(characters: List(String), stack: List(String)) -> Bool {
  case characters {
    [] -> stack == []
    [character, ..rest] ->
      case character {
        "(" | "[" | "{" -> check(rest, [character, ..stack])
        ")" -> pop_if_matching(rest, stack, "(")
        "]" -> pop_if_matching(rest, stack, "[")
        "}" -> pop_if_matching(rest, stack, "{")
        _ -> check(rest, stack)
      }
  }
}

fn pop_if_matching(characters: List(String), stack: List(String), expected: String) -> Bool {
  case stack {
    [top, ..rest] if top == expected -> check(characters, rest)
    _ -> False
  }
}
