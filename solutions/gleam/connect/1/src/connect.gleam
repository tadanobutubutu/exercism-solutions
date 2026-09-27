import gleam/list
import gleam/string

pub type Player {
  X
  O
}

pub fn winner(board: String) -> Result(Player, Nil) {
  let rows =
    board
    |> string.split(on: "\n")
    |> parse_rows([])
  let size = list.length(rows)
  case size {
    0 -> Error(Nil)
    _ -> {
      let x_starts = start_x(rows, size, 0, [])
      let o_starts = start_o(rows, size)
      case has_path(rows, x_starts, [], X, size) {
        True -> Ok(X)
        False ->
          case has_path(rows, o_starts, [], O, size) {
            True -> Ok(O)
            False -> Error(Nil)
          }
      }
    }
  }
}

fn parse_rows(lines: List(String), result: List(List(String))) -> List(List(String)) {
  case lines {
    [] -> list.reverse(result)
    [line, ..rest] ->
      case string.trim(line) {
        "" -> parse_rows(rest, result)
        trimmed -> {
          let cells = string.split(trimmed, on: " ") |> remove_empty_tokens([])
          parse_rows(rest, [cells, ..result])
        }
      }
  }
}

fn remove_empty_tokens(tokens: List(String), result: List(String)) -> List(String) {
  case tokens {
    [] -> list.reverse(result)
    [token, ..rest] ->
      case token {
        "" -> remove_empty_tokens(rest, result)
        _ -> remove_empty_tokens(rest, [token, ..result])
      }
  }
}

fn start_x(rows: List(List(String)), size: Int, row: Int, result: List(#(Int, Int))) -> List(#(Int, Int)) {
  case row >= size {
    True -> result
    False ->
      case cell(rows, row, 0) {
        "X" -> start_x(rows, size, row + 1, [#(row, 0), ..result])
        _ -> start_x(rows, size, row + 1, result)
      }
  }
}

fn start_o(rows: List(List(String)), size: Int) -> List(#(Int, Int)) {
  case list.drop(rows, 0) {
    [] -> []
    [first, .._] -> start_o_columns(first, size, 0, [])
  }
}

fn start_o_columns(row: List(String), size: Int, column: Int, result: List(#(Int, Int))) -> List(#(Int, Int)) {
  case column >= size {
    True -> result
    False ->
      case cell_at(row, column) {
        "O" -> start_o_columns(row, size, column + 1, [#(0, column), ..result])
        _ -> start_o_columns(row, size, column + 1, result)
      }
  }
}

fn has_path(
  rows: List(List(String)),
  frontier: List(#(Int, Int)),
  visited: List(#(Int, Int)),
  player: Player,
  size: Int,
) -> Bool {
  case frontier {
    [] -> False
    [#(row, column), ..rest] ->
      case contains(visited, #(row, column)) {
        True -> has_path(rows, rest, visited, player, size)
        False ->
          case cell(rows, row, column) == player_mark(player) {
            False -> has_path(rows, rest, [#(row, column), ..visited], player, size)
            True ->
              case reaches_goal(player, row, column, size) {
                True -> True
                False -> {
                  let next =
                    [
                      #(row - 1, column),
                      #(row - 1, column + 1),
                      #(row, column - 1),
                      #(row, column + 1),
                      #(row + 1, column - 1),
                      #(row + 1, column),
                    ]
                  has_path(rows, list.append(next, rest), [#(row, column), ..visited], player, size)
                }
              }
          }
      }
  }
}

fn reaches_goal(player: Player, row: Int, column: Int, size: Int) -> Bool {
  case player {
    X -> column == size - 1
    O -> row == size - 1
  }
}

fn player_mark(player: Player) -> String {
  case player {
    X -> "X"
    O -> "O"
  }
}

fn contains(positions: List(#(Int, Int)), target: #(Int, Int)) -> Bool {
  case positions {
    [] -> False
    [position, ..rest] -> position == target || contains(rest, target)
  }
}

fn cell(rows: List(List(String)), row: Int, column: Int) -> String {
  case row < 0 || column < 0 {
    True -> ""
    False ->
      case list.drop(rows, row) {
        [] -> ""
        [cells, .._] -> cell_at(cells, column)
      }
  }
}

fn cell_at(cells: List(String), column: Int) -> String {
  case list.drop(cells, column) {
    [] -> ""
    [cell, .._] -> cell
  }
}
