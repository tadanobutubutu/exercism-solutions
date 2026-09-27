import gleam/list

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  case knocked_pins < 0 || knocked_pins > 10 {
    True -> Error(InvalidPinCount)
    False -> roll_valid(game, knocked_pins)
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  case game {
    Game(frames) -> case list.reverse(frames) {
      [Frame(rolls: tenth_rolls, bonus: _), .._] -> case list.length(frames) == 10 && tenth_complete(tenth_rolls) {
        False -> Error(GameNotComplete)
        True -> {
          let first_nine = list.take(frames, 9)
          let all_rolls = list.flatten(list.map(frames, fn(frame) { frame.rolls }))
          let earlier_score = score_frames(first_nine, all_rolls, 0)
          let tenth_score = list.fold(tenth_rolls, 0, fn(total, pins) { total + pins })
          Ok(earlier_score + tenth_score)
        }
      }
      [] -> Error(GameNotComplete)
    }
  }
}

fn roll_valid(game: Game, pins: Int) -> Result(Game, Error) {
  case game {
    Game([]) -> Ok(Game([Frame(rolls: [pins], bonus: [])]))
    Game(frames) -> {
      let frame_number = list.length(frames)
      case frame_number >= 10 {
        True -> roll_tenth(frames, pins)
        False -> roll_before_tenth(frames, pins)
      }
    }
  }
}

fn roll_before_tenth(frames: List(Frame), pins: Int) -> Result(Game, Error) {
  case list.reverse(frames) {
    [Frame(rolls: rolls, bonus: bonus), ..reversed_rest] -> case rolls {
      [10] -> Ok(Game(list.append(frames, [Frame(rolls: [pins], bonus: [])])))
      [_first, _second] -> Ok(Game(list.append(frames, [Frame(rolls: [pins], bonus: [])])))
      [first] -> case first + pins > 10 {
        True -> Error(InvalidPinCount)
        False -> {
          let updated = Frame(rolls: [first, pins], bonus: bonus)
          Ok(Game(list.reverse([updated, ..reversed_rest])))
        }
      }
      [] -> Error(GameNotComplete)
      _ -> Error(GameNotComplete)
    }
    [] -> Error(GameNotComplete)
  }
}

fn roll_tenth(frames: List(Frame), pins: Int) -> Result(Game, Error) {
  case list.reverse(frames) {
    [Frame(rolls: rolls, bonus: bonus), ..reversed_rest] -> case tenth_complete(rolls) {
      True -> Error(GameComplete)
      False -> case rolls {
        [first] -> case first == 10 || first + pins <= 10 {
          False -> Error(InvalidPinCount)
          True -> replace_last(reversed_rest, Frame(rolls: [first, pins], bonus: bonus))
        }
        [first, second] -> case tenth_third_roll_allowed(first, second, pins) {
          False -> Error(InvalidPinCount)
          True -> replace_last(reversed_rest, Frame(rolls: [first, second, pins], bonus: bonus))
        }
        _ -> Error(GameComplete)
      }
    }
    [] -> Error(GameNotComplete)
  }
}

fn tenth_third_roll_allowed(first: Int, second: Int, pins: Int) -> Bool {
  case first == 10 || first + second == 10 {
    True -> case first == 10 && second != 10 {
      True -> second + pins <= 10
      False -> True
    }
    False -> False
  }
}

fn tenth_complete(rolls: List(Int)) -> Bool {
  case rolls {
    [10, second, third] -> second == 10 || second + third <= 10
    [first, second, _third] -> first + second == 10
    [first, second] -> first != 10 && first + second < 10
    [10] -> False
    [_] -> False
    _ -> False
  }
}

fn replace_last(reversed_rest: List(Frame), new_last: Frame) -> Result(Game, Error) {
  Ok(Game(list.reverse([new_last, ..reversed_rest])))
}

fn score_frames(frames: List(Frame), all_rolls: List(Int), total: Int) -> Int {
  case frames {
    [] -> total
    [Frame(rolls: rolls, bonus: _), ..rest] -> case rolls {
      [10] -> {
        let points = 10 + roll_at(all_rolls, 1) + roll_at(all_rolls, 2)
        score_frames(rest, list.drop(all_rolls, 1), total + points)
      }
      [first, second] -> case first + second == 10 {
        True -> {
          let points = 10 + roll_at(all_rolls, 2)
          score_frames(rest, list.drop(all_rolls, 2), total + points)
        }
        False -> score_frames(rest, list.drop(all_rolls, 2), total + first + second)
      }
      _ -> total
    }
  }
}

fn roll_at(rolls: List(Int), index: Int) -> Int {
  case list.drop(rolls, index) {
    [pins, .._] -> pins
    [] -> 0
  }
}
