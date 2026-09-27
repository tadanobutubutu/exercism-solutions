pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  flatten_node(nested_list, []) |> reverse([])
}

fn flatten_node(nested: NestedList(a), result: List(a)) -> List(a) {
  case nested {
    Null -> result
    Value(value) -> [value, ..result]
    List(values) -> flatten_values(values, result)
  }
}

fn flatten_values(values: List(NestedList(a)), result: List(a)) -> List(a) {
  case values {
    [] -> result
    [value, ..rest] -> flatten_values(rest, flatten_node(value, result))
  }
}

fn reverse(values: List(a), result: List(a)) -> List(a) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
