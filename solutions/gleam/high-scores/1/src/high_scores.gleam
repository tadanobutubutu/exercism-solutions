import gleam/int
import gleam/list

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  case high_scores {
    [latest, ..] -> Ok(latest)
    [] -> Error(Nil)
  }
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  case high_scores {
    [] -> Error(Nil)
    [first, ..rest] -> Ok(maximum(rest, first))
  }
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores
  |> list.sort(by: int.compare)
  |> list.reverse
  |> list.take(3)
}

fn maximum(scores: List(Int), best: Int) -> Int {
  case scores {
    [] -> best
    [score, ..rest] if score > best -> maximum(rest, score)
    [_, ..rest] -> maximum(rest, best)
  }
}
