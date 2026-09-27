pub fn score(x: Float, y: Float) -> Int {
  let distance_squared = x *. x +. y *. y
  case distance_squared {
    distance if distance <=. 1.0 -> 10
    distance if distance <=. 25.0 -> 5
    distance if distance <=. 100.0 -> 1
    _ -> 0
  }
}
