import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  move_instructions(direction, position, string.to_graphemes(instructions))
}

fn move_instructions(
  direction: Direction,
  position: Position,
  instructions: List(String),
) -> Robot {
  case instructions {
    [] -> Robot(direction, position)
    [instruction, ..rest] ->
      case instruction {
        "R" -> move_instructions(turn_right(direction), position, rest)
        "L" -> move_instructions(turn_left(direction), position, rest)
        "A" -> move_instructions(direction, advance(direction, position), rest)
        _ -> move_instructions(direction, position, rest)
      }
  }
}

fn turn_right(direction: Direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

fn turn_left(direction: Direction) -> Direction {
  case direction {
    North -> West
    West -> South
    South -> East
    East -> North
  }
}

fn advance(direction: Direction, position: Position) -> Position {
  case position {
    Position(x, y) ->
      case direction {
        North -> Position(x: x, y: y + 1)
        East -> Position(x: x + 1, y: y)
        South -> Position(x: x, y: y - 1)
        West -> Position(x: x - 1, y: y)
      }
  }
}
