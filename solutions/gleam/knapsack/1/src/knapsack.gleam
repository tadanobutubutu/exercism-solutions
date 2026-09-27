pub type Item {
  Item(value: Int, weight: Int)
}

pub fn maximum_value(items: List(Item), maximum_weight: Int) -> Int {
  case items {
    [] -> 0
    [Item(value: value, weight: weight), ..rest] ->
      case weight > maximum_weight {
        True -> maximum_value(rest, maximum_weight)
        False -> {
          let without_item = maximum_value(rest, maximum_weight)
          let with_item = value + maximum_value(rest, maximum_weight - weight)
          case with_item > without_item {
            True -> with_item
            False -> without_item
          }
        }
      }
  }
}
