import gleam/list

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  accumulate_reversed(list, fun, []) |> list.reverse
}

fn accumulate_reversed(list: List(a), fun: fn(a) -> b, reversed: List(b)) -> List(b) {
  case list {
    [] -> reversed
    [item, ..rest] -> accumulate_reversed(rest, fun, [fun(item), ..reversed])
  }
}
