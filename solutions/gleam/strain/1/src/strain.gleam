pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [first, ..rest] ->
      case predicate(first) {
        True -> [first, ..keep(rest, predicate)]
        False -> keep(rest, predicate)
      }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [first, ..rest] ->
      case predicate(first) {
        True -> discard(rest, predicate)
        False -> [first, ..discard(rest, predicate)]
      }
  }
}
