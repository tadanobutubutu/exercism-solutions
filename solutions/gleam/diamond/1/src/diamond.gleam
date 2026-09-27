import gleam/list
import gleam/string

pub fn build(letter: String) -> String {
  let alphabet = string.to_graphemes("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  let index = find_index(alphabet, letter, 0)
  let upper = build_upper(0, index, alphabet, [])
  let lower = upper |> list.take(index) |> list.reverse
  list.append(upper, lower) |> string.join("\n")
}

fn build_upper(index: Int, last: Int, alphabet: List(String), rows: List(String)) -> List(String) {
  case index > last {
    True -> rows
    False -> {
      let width = last * 2 + 1
      let row = build_row(0, width, last - index, at(alphabet, index), "")
      build_upper(index + 1, last, alphabet, list.append(rows, [row]))
    }
  }
}

fn build_row(position: Int, width: Int, left: Int, letter: String, row: String) -> String {
  case position >= width {
    True -> row
    False -> {
      let right = width - 1 - left
      let cell = case position == left || position == right {
        True -> letter
        False -> " "
      }
      build_row(position + 1, width, left, letter, row <> cell)
    }
  }
}

fn find_index(letters: List(String), target: String, index: Int) -> Int {
  case letters {
    [] -> 0
    [letter, ..rest] -> case letter == target {
      True -> index
      False -> find_index(rest, target, index + 1)
    }
  }
}

fn at(letters: List(String), index: Int) -> String {
  case list.drop(letters, index) {
    [letter, .._] -> letter
    [] -> "A"
  }
}
