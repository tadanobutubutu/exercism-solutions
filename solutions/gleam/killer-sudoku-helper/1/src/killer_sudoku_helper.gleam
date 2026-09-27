import gleam/list

pub fn combinations(
  size size: Int,
  sum sum: Int,
  exclude exclude: List(Int),
) -> List(List(Int)) {
  choose(1, size, sum, exclude, [])
}

fn choose(
  next: Int,
  remaining_size: Int,
  remaining_sum: Int,
  exclude: List(Int),
  chosen: List(Int),
) -> List(List(Int)) {
  case remaining_size == 0 {
    True ->
      case remaining_sum == 0 {
        True -> [reverse(chosen, [])]
        False -> []
      }
    False ->
      case next > 9 || remaining_sum <= 0 {
        True -> []
        False -> {
          let skip_current = choose(
            next + 1,
            remaining_size,
            remaining_sum,
            exclude,
            chosen,
          )
          case contains(exclude, next) {
            True -> skip_current
            False -> {
              let include_current = choose(
                next + 1,
                remaining_size - 1,
                remaining_sum - next,
                exclude,
                [next, ..chosen],
              )
              list.append(include_current, skip_current)
            }
          }
        }
      }
  }
}

fn contains(values: List(Int), value: Int) -> Bool {
  case values {
    [] -> False
    [first, ..rest] ->
      case first == value {
        True -> True
        False -> contains(rest, value)
      }
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [first, ..rest] -> reverse(rest, [first, ..result])
  }
}
