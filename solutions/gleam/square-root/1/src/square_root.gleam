pub fn square_root(radicand: Int) -> Int {
  search(radicand, 1, radicand)
}

fn search(radicand: Int, low: Int, high: Int) -> Int {
  let middle = (low + high) / 2
  let square = middle * middle

  case square {
    value if value == radicand -> middle
    value if value > radicand -> search(radicand, low, middle - 1)
    _ -> search(radicand, middle + 1, high)
  }
}
