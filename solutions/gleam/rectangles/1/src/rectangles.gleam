import gleam/list
import gleam/string

pub fn rectangles(input: String) -> Int {
  let rows = string.split(input, on: "\n") |> non_empty_rows([])
  count_top_rows(rows, rows, 0, 0)
}

fn non_empty_rows(rows: List(String), result: List(String)) -> List(String) {
  case rows {
    [] -> reverse_strings(result, [])
    [row, ..rest] ->
      case row {
        "" -> non_empty_rows(rest, result)
        _ -> non_empty_rows(rest, [row, ..result])
      }
  }
}

fn count_top_rows(
  remaining: List(String),
  rows: List(String),
  top: Int,
  total: Int,
) -> Int {
  case remaining {
    [] -> total
    [_row, ..rest] -> {
      let count = count_bottom_rows(rows, rows, top, top + 1, total)
      count_top_rows(rest, rows, top + 1, count)
    }
  }
}

fn count_bottom_rows(
  remaining: List(String),
  rows: List(String),
  top: Int,
  bottom: Int,
  total: Int,
) -> Int {
  case remaining {
    [] -> total
    [_row, ..rest] -> {
      let count = count_column_pairs(rows, top, bottom, 0, total)
      count_bottom_rows(rest, rows, top, bottom + 1, count)
    }
  }
}

fn count_column_pairs(
  rows: List(String),
  top: Int,
  bottom: Int,
  left: Int,
  total: Int,
) -> Int {
  let width = row_width(rows)
  case left >= width {
    True -> total
    False -> {
      let count =
        case corner(rows, top, left) && corner(rows, bottom, left) && vertical(rows, top, bottom, left) {
          True -> count_right_columns(rows, top, bottom, left + 1, width, total)
          False -> total
        }
      count_column_pairs(rows, top, bottom, left + 1, count)
    }
  }
}

fn count_right_columns(
  rows: List(String),
  top: Int,
  bottom: Int,
  left: Int,
  width: Int,
  total: Int,
) -> Int {
  count_right_from(rows, top, bottom, left, left + 1, width, total)
}

fn count_right_from(
  rows: List(String),
  top: Int,
  bottom: Int,
  left: Int,
  right: Int,
  width: Int,
  total: Int,
) -> Int {
  case right >= width {
    True -> total
    False -> {
      let complete =
        corner(rows, top, right)
          && corner(rows, bottom, right)
          && vertical(rows, top, bottom, right)
          && horizontal(rows, top, left, right)
          && horizontal(rows, bottom, left, right)
      let updated = case complete { True -> total + 1 False -> total }
      count_right_from(rows, top, bottom, left, right + 1, width, updated)
    }
  }
}

fn corner(rows: List(String), row: Int, column: Int) -> Bool {
  cell(rows, row, column) == "+"
}

fn horizontal(rows: List(String), row: Int, column: Int, end: Int) -> Bool {
  case column > end {
    True -> True
    False ->
      case cell(rows, row, column) {
        "+" | "-" -> horizontal(rows, row, column + 1, end)
        _ -> False
      }
  }
}

fn vertical(rows: List(String), row: Int, end: Int, column: Int) -> Bool {
  case row > end {
    True -> True
    False ->
      case cell(rows, row, column) {
        "+" | "|" -> vertical(rows, row + 1, end, column)
        _ -> False
      }
  }
}

fn cell(rows: List(String), row: Int, column: Int) -> String {
  case list.drop(rows, row) {
    [] -> ""
    [line, .._] ->
      case list.drop(string.to_graphemes(line), column) {
        [] -> ""
        [character, .._] -> character
      }
  }
}

fn row_width(rows: List(String)) -> Int {
  case rows {
    [] -> 0
    [first, .._] -> string.to_graphemes(first) |> list.length
  }
}

fn reverse_strings(values: List(String), result: List(String)) -> List(String) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_strings(rest, [value, ..result])
  }
}
