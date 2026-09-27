pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen.row {
    row if row < 0 -> Error(RowTooSmall)
    row if row > 7 -> Error(RowTooLarge)
    _ ->
      case queen.column {
        column if column < 0 -> Error(ColumnTooSmall)
        column if column > 7 -> Error(ColumnTooLarge)
        _ -> Ok(Nil)
      }
  }
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  let row_difference = absolute(black_queen.row - white_queen.row)
  let column_difference = absolute(black_queen.column - white_queen.column)

  black_queen != white_queen
    && (black_queen.row == white_queen.row
      || black_queen.column == white_queen.column
      || row_difference == column_difference)
}

fn absolute(number: Int) -> Int {
  case number < 0 {
    True -> -number
    False -> number
  }
}
