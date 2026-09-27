import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  let first = string.to_graphemes(strand1)
  let second = string.to_graphemes(strand2)

  case list_length(first) == list_length(second) {
    True -> Ok(count_differences(first, second, 0))
    False -> Error(Nil)
  }
}

fn list_length(items: List(String)) -> Int {
  case items {
    [] -> 0
    [_, ..rest] -> 1 + list_length(rest)
  }
}

fn count_differences(first: List(String), second: List(String), count: Int) -> Int {
  case #(first, second) {
    #([], []) -> count
    #([left, ..left_rest], [right, ..right_rest]) ->
      case left == right {
        True -> count_differences(left_rest, right_rest, count)
        False -> count_differences(left_rest, right_rest, count + 1)
      }
    _ -> count
  }
}
