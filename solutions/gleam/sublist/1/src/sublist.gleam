pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

import gleam/list

pub fn sublist(compare list_a: List(a), to list_b: List(a)) -> Comparison {
  case list_a == list_b {
    True -> Equal
    False ->
      case is_sublist(list_a, list_b) {
        True -> Sublist
        False ->
          case is_sublist(list_b, list_a) {
            True -> Superlist
            False -> Unequal
          }
      }
  }
}

fn is_sublist(smaller: List(a), larger: List(a)) -> Bool {
  let smaller_length = list.length(smaller)
  case smaller_length > list.length(larger) {
    True -> False
    False ->
      case list.take(larger, smaller_length) == smaller {
        True -> True
        False ->
          case larger {
            [] -> False
            [_first, ..rest] -> is_sublist(smaller, rest)
          }
      }
  }
}
