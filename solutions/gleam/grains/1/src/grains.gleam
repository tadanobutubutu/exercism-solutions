pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square < 1 || square > 64 {
    True -> Error(InvalidSquare)
    False -> Ok(grains_on_square(square, 1))
  }
}

pub fn total() -> Int {
  total_grains(1, 1, 0)
}

fn grains_on_square(square: Int, grains: Int) -> Int {
  case square {
    1 -> grains
    _ -> grains_on_square(square - 1, grains * 2)
  }
}

fn total_grains(square: Int, grains: Int, total: Int) -> Int {
  case square {
    65 -> total
    _ -> total_grains(square + 1, grains * 2, total + grains)
  }
}
