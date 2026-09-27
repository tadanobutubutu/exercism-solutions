import gleam/list
import gleam/string

pub type Output {
  Unknown
  Digit(Int)
  List(List(Output))
}

pub type Error {
  InvalidLineNumber
  InvalidRowNumber
}

pub fn convert(input: String) -> Result(Output, Error) {
  let lines = input |> string.split(on: "\n") |> remove_empty_lines([])
  let line_count = list.length(lines)

  case line_count == 0 || line_count % 4 != 0 {
    True -> Error(InvalidLineNumber)
    False ->
      case valid_groups(lines) {
        False -> Error(InvalidRowNumber)
        True -> Ok(format_output(parse_groups(lines, [])))
      }
  }
}

fn remove_empty_lines(lines: List(String), result: List(String)) -> List(String) {
  case lines {
    [] -> reverse_strings(result, [])
    [line, ..rest] ->
      case line {
        "" -> remove_empty_lines(rest, result)
        _ -> remove_empty_lines(rest, [line, ..result])
      }
  }
}

fn valid_groups(lines: List(String)) -> Bool {
  case lines {
    [] -> True
    [first, second, third, fourth, ..rest] -> {
      let first_width = string.to_graphemes(first) |> list.length
      let widths_match =
        first_width == list.length(string.to_graphemes(second))
          && first_width == list.length(string.to_graphemes(third))
          && first_width == list.length(string.to_graphemes(fourth))
      first_width > 0 && first_width % 3 == 0 && widths_match && valid_groups(rest)
    }
    _ -> False
  }
}

fn parse_groups(lines: List(String), result: List(List(Output))) -> List(List(Output)) {
  case lines {
    [] -> reverse_rows(result, [])
    [first, second, third, fourth, ..rest] -> {
      let width = string.to_graphemes(first) |> list.length
      let row = parse_columns([first, second, third, fourth], 0, width, [])
      parse_groups(rest, [row, ..result])
    }
    _ -> reverse_rows(result, [])
  }
}

fn parse_columns(
  rows: List(String),
  column: Int,
  width: Int,
  result: List(Output),
) -> List(Output) {
  case column >= width {
    True -> reverse_outputs(result, [])
    False -> {
      let assert [first, second, third, fourth] = rows
      let cell = [
        slice(first, column),
        slice(second, column),
        slice(third, column),
        slice(fourth, column),
      ]
      parse_columns(rows, column + 3, width, [decode_cell(cell), ..result])
    }
  }
}

fn slice(line: String, column: Int) -> String {
  line
  |> string.to_graphemes
  |> list.drop(column)
  |> list.take(3)
  |> string.concat
}

fn decode_cell(cell: List(String)) -> Output {
  case cell {
    [" _ ", "| |", "|_|", "   "] -> Digit(0)
    ["   ", "  |", "  |", "   "] -> Digit(1)
    [" _ ", " _|", "|_ ", "   "] -> Digit(2)
    [" _ ", " _|", " _|", "   "] -> Digit(3)
    ["   ", "|_|", "  |", "   "] -> Digit(4)
    [" _ ", "|_ ", " _|", "   "] -> Digit(5)
    [" _ ", "|_ ", "|_|", "   "] -> Digit(6)
    [" _ ", "  |", "  |", "   "] -> Digit(7)
    [" _ ", "|_|", "|_|", "   "] -> Digit(8)
    [" _ ", "|_|", " _|", "   "] -> Digit(9)
    _ -> Unknown
  }
}

fn format_output(groups: List(List(Output))) -> Output {
  case groups {
    [row] ->
      case row {
        [single] -> single
        _ -> List(row)
      }
    _ -> List(groups)
  }
}

fn reverse_strings(values: List(String), result: List(String)) -> List(String) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_strings(rest, [value, ..result])
  }
}

fn reverse_outputs(values: List(Output), result: List(Output)) -> List(Output) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_outputs(rest, [value, ..result])
  }
}

fn reverse_rows(values: List(List(Output)), result: List(List(Output))) -> List(List(Output)) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_rows(rest, [value, ..result])
  }
}
