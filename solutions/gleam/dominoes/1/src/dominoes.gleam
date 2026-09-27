import gleam/list

pub fn can_chain(chain: List(#(Int, Int))) -> Bool {
  case chain {
    [] -> True
    [#(left, right), ..rest] ->
      search(rest, left, right) || (left != right && search(rest, right, left))
  }
}

fn search(remaining: List(#(Int, Int)), start: Int, current: Int) -> Bool {
  case remaining {
    [] -> current == start
    _ -> try_each(remaining, start, current, [])
  }
}

fn try_each(
  remaining: List(#(Int, Int)),
  start: Int,
  current: Int,
  preceding_reversed: List(#(Int, Int)),
) -> Bool {
  case remaining {
    [] -> False
    [#(left, right) as domino, ..rest] -> {
      let without_domino = list.append(list.reverse(preceding_reversed), rest)
      let can_use_forward = left == current && search(without_domino, start, right)
      let can_use_reverse =
        !can_use_forward
        && right == current
        && left != right
        && search(without_domino, start, left)
      case can_use_forward || can_use_reverse {
        True -> True
        False -> try_each(rest, start, current, [domino, ..preceding_reversed])
      }
    }
  }
}
