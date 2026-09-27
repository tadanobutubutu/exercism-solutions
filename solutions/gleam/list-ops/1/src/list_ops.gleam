pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  case first {
    [] -> second
    [element, ..rest] -> [element, ..append(rest, second)]
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  case lists {
    [] -> []
    [first, ..rest] -> append(first, concat(rest))
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  case list {
    [] -> []
    [element, ..rest] ->
      case function(element) {
        True -> [element, ..filter(rest, function)]
        False -> filter(rest, function)
      }
  }
}

pub fn length(list: List(a)) -> Int {
  case list {
    [] -> 0
    [_element, ..rest] -> 1 + length(rest)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [element, ..rest] -> [function(element), ..map(rest, function)]
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [element, ..rest] -> foldl(over: rest, from: function(initial, element), with: function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [element, ..rest] -> function(foldr(over: rest, from: initial, with: function), element)
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  reverse_with_accumulator(list, [])
}

fn reverse_with_accumulator(list: List(a), result: List(a)) -> List(a) {
  case list {
    [] -> result
    [element, ..rest] -> reverse_with_accumulator(rest, [element, ..result])
  }
}
