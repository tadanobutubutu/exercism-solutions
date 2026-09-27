pub opaque type Set(t) {
  Set(values: List(t))
}

pub fn new(members: List(t)) -> Set(t) {
  build(members, Set(values: []))
}

pub fn is_empty(set: Set(t)) -> Bool {
  case set {
    Set(values: []) -> True
    Set(values: _) -> False
  }
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  case set {
    Set(values: values) -> contains_value(values, member)
  }
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  case first {
    Set(values: values) -> all_in(values, second)
  }
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  case first {
    Set(values: values) -> none_in(values, second)
  }
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  is_subset(first, of: second) && is_subset(second, of: first)
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  case contains(in: set, this: member) {
    True -> set
    False ->
      case set {
        Set(values: values) -> Set(values: [member, ..values])
      }
  }
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  case first {
    Set(values: values) -> Set(values: intersection_values(values, second, []))
  }
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  case first {
    Set(values: values) -> Set(values: difference_values(values, second, []))
  }
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  case second {
    Set(values: values) -> union_values(values, first)
  }
}

fn build(values: List(t), set: Set(t)) -> Set(t) {
  case values {
    [] -> set
    [value, ..rest] -> build(rest, add(to: set, this: value))
  }
}

fn contains_value(values: List(t), target: t) -> Bool {
  case values {
    [] -> False
    [value, ..rest] -> value == target || contains_value(rest, target)
  }
}

fn all_in(values: List(t), set: Set(t)) -> Bool {
  case values {
    [] -> True
    [value, ..rest] -> contains(in: set, this: value) && all_in(rest, set)
  }
}

fn none_in(values: List(t), set: Set(t)) -> Bool {
  case values {
    [] -> True
    [value, ..rest] -> !contains(in: set, this: value) && none_in(rest, set)
  }
}

fn intersection_values(values: List(t), set: Set(t), result: List(t)) -> List(t) {
  case values {
    [] -> reverse(result, [])
    [value, ..rest] ->
      case contains(in: set, this: value) {
        True -> intersection_values(rest, set, [value, ..result])
        False -> intersection_values(rest, set, result)
      }
  }
}

fn difference_values(values: List(t), set: Set(t), result: List(t)) -> List(t) {
  case values {
    [] -> reverse(result, [])
    [value, ..rest] ->
      case contains(in: set, this: value) {
        True -> difference_values(rest, set, result)
        False -> difference_values(rest, set, [value, ..result])
      }
  }
}

fn union_values(values: List(t), set: Set(t)) -> Set(t) {
  case values {
    [] -> set
    [value, ..rest] -> union_values(rest, add(to: set, this: value))
  }
}

fn reverse(values: List(t), result: List(t)) -> List(t) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
