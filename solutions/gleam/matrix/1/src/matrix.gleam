import gleam/int
import gleam/list
import gleam/string

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  case parse_matrix(string) {
    Error(Nil) -> Error(Nil)
    Ok(rows) -> row_at(rows, index)
  }
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  case parse_matrix(string) {
    Error(Nil) -> Error(Nil)
    Ok(rows) -> column_at(rows, index - 1, [])
  }
}

fn parse_matrix(matrix: String) -> Result(List(List(Int)), Nil) {
  parse_rows(string.split(matrix, on: "\n"), [])
}

fn parse_rows(rows: List(String), parsed: List(List(Int))) -> Result(List(List(Int)), Nil) {
  case rows {
    [] -> Ok(list.reverse(parsed))
    [row, ..rest] ->
      case parse_numbers(row) {
        Ok(numbers) -> parse_rows(rest, [numbers, ..parsed])
        Error(Nil) -> Error(Nil)
      }
  }
}

fn parse_numbers(row: String) -> Result(List(Int), Nil) {
  let parts =
    row
    |> string.trim
    |> string.split(on: " ")
    |> list.filter(fn(part) { part != "" })
  parse_ints(parts, [])
}

fn parse_ints(parts: List(String), parsed: List(Int)) -> Result(List(Int), Nil) {
  case parts {
    [] -> Ok(list.reverse(parsed))
    [part, ..rest] ->
      case int.parse(part) {
        Ok(number) -> parse_ints(rest, [number, ..parsed])
        Error(_) -> Error(Nil)
      }
  }
}

fn row_at(rows: List(List(Int)), index: Int) -> Result(List(Int), Nil) {
  case index > 0 {
    False -> Error(Nil)
    True ->
      case list.drop(rows, index - 1) {
        [values, ..] -> Ok(values)
        [] -> Error(Nil)
      }
  }
}

fn column_at(rows: List(List(Int)), index: Int, values: List(Int)) -> Result(List(Int), Nil) {
  case index >= 0 {
    False -> Error(Nil)
    True -> column_values(rows, index, values)
  }
}

fn column_values(
  rows: List(List(Int)),
  index: Int,
  values: List(Int),
) -> Result(List(Int), Nil) {
  case rows {
    [] ->
      case values {
        [] -> Error(Nil)
        _ -> Ok(list.reverse(values))
      }
    [row, ..rest] ->
      case int_at(row, index) {
        Ok(value) -> column_values(rest, index, [value, ..values])
        Error(Nil) -> Error(Nil)
      }
  }
}

fn int_at(values: List(Int), index: Int) -> Result(Int, Nil) {
  case list.drop(values, index) {
    [value, ..] -> Ok(value)
    [] -> Error(Nil)
  }
}
