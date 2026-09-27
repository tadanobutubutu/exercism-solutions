pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  search_first(1, sum, []) |> reverse([])
}

fn search_first(first: Int, sum: Int, result: List(Triplet)) -> List(Triplet) {
  case first * 3 >= sum {
    True -> result
    False -> search_first(first + 1, sum, search_second(first, first + 1, sum, result))
  }
}

fn search_second(first: Int, second: Int, sum: Int, result: List(Triplet)) -> List(Triplet) {
  let third = sum - first - second
  case second >= third {
    True -> result
    False ->
      case first * first + second * second == third * third {
        True -> search_second(first, second + 1, sum, [Triplet(first, second, third), ..result])
        False -> search_second(first, second + 1, sum, result)
      }
  }
}

fn reverse(values: List(Triplet), result: List(Triplet)) -> List(Triplet) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
