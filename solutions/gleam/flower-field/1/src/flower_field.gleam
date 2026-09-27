import gleam/list
import gleam/string

pub fn annotate(garden: String) -> String {
  case garden {
    "" -> ""
    _ -> {
      let rows = string.split(garden, on: "\n")
      annotate_rows(rows, rows, 0, "")
    }
  }
}

fn annotate_rows(
  remaining: List(String),
  garden: List(String),
  row_number: Int,
  result: String,
) -> String {
  case remaining {
    [] -> result
    [row, ..rest] -> {
      let cells = string.to_graphemes(row)
      let annotated = annotate_cells(cells, garden, row_number, 0, "")
      let updated =
        case row_number {
          0 -> annotated
          _ -> result <> "\n" <> annotated
        }
      annotate_rows(rest, garden, row_number + 1, updated)
    }
  }
}

fn annotate_cells(
  remaining: List(String),
  garden: List(String),
  row: Int,
  column: Int,
  result: String,
) -> String {
  case remaining {
    [] -> result
    [cell, ..rest] -> {
      let updated_cell =
        case cell {
          "*" -> "*"
          _ -> {
            let flowers = neighbor_count(garden, row, column)
            case flowers {
              0 -> cell
              _ -> int.to_string(flowers)
            }
          }
        }
      annotate_cells(rest, garden, row, column + 1, result <> updated_cell)
    }
  }
}

fn neighbor_count(garden: List(String), row: Int, column: Int) -> Int {
  flower(garden, row - 1, column - 1)
  + flower(garden, row - 1, column)
  + flower(garden, row - 1, column + 1)
  + flower(garden, row, column - 1)
  + flower(garden, row, column + 1)
  + flower(garden, row + 1, column - 1)
  + flower(garden, row + 1, column)
  + flower(garden, row + 1, column + 1)
}

fn flower(garden: List(String), row: Int, column: Int) -> Int {
  case list.drop(garden, row) {
    [] -> 0
    [line, .._] ->
      case list.drop(string.to_graphemes(line), column) {
        ["*", .._] -> 1
        _ -> 0
      }
  }
}
