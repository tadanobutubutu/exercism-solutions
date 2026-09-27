import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  build_rows(n, 1, [1], [])
}

fn build_rows(
  target: Int,
  index: Int,
  previous: List(Int),
  result: List(List(Int)),
) -> List(List(Int)) {
  case index > target {
    True -> result
    False -> {
      let current =
        case index {
          1 -> [1]
          _ -> list.append([1], list.append(adjacent_sums(previous), [1]))
        }
      build_rows(target, index + 1, current, list.append(result, [current]))
    }
  }
}

fn adjacent_sums(values: List(Int)) -> List(Int) {
  case values {
    [first, second, ..rest] -> [first + second, ..adjacent_sums([second, ..rest])]
    _ -> []
  }
}
