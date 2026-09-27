import gleam/list

pub type Position {
  Position(row: Int, column: Int)
}

pub fn saddle_points(matrix: List(List(Int))) -> List(Position) {
  find_points(matrix, matrix, 1, [])
}

fn find_points(
  remaining_rows: List(List(Int)),
  matrix: List(List(Int)),
  row_number: Int,
  result: List(Position),
) -> List(Position) {
  case remaining_rows {
    [] -> reverse_positions(result, [])
    [row, ..rest] ->
      case row {
        [] -> find_points(rest, matrix, row_number + 1, result)
        [first, .._] -> {
          let maximum = row_maximum(row, first)
          let updated = find_columns(row, matrix, row_number, 1, maximum, result)
          find_points(rest, matrix, row_number + 1, updated)
        }
      }
  }
}

fn row_maximum(values: List(Int), maximum: Int) -> Int {
  case values {
    [] -> maximum
    [value, ..rest] ->
      case value > maximum {
        True -> row_maximum(rest, value)
        False -> row_maximum(rest, maximum)
      }
  }
}

fn find_columns(
  values: List(Int),
  matrix: List(List(Int)),
  row: Int,
  column: Int,
  maximum: Int,
  result: List(Position),
) -> List(Position) {
  case values {
    [] -> result
    [value, ..rest] -> {
      let updated =
        case value == maximum && is_column_minimum(matrix, column, value) {
          True -> [Position(row: row, column: column), ..result]
          False -> result
        }
      find_columns(rest, matrix, row, column + 1, maximum, updated)
    }
  }
}

fn is_column_minimum(rows: List(List(Int)), column: Int, value: Int) -> Bool {
  case rows {
    [] -> True
    [row, ..rest] ->
      case list.drop(row, column - 1) {
        [] -> is_column_minimum(rest, column, value)
        [cell, .._] -> cell >= value && is_column_minimum(rest, column, value)
      }
  }
}

fn reverse_positions(values: List(Position), result: List(Position)) -> List(Position) {
  case values {
    [] -> result
    [value, ..rest] -> reverse_positions(rest, [value, ..result])
  }
}
