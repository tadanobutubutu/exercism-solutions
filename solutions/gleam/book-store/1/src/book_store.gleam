import gleam/dict.{type Dict}

pub fn lowest_price(books: List(Int)) -> Float {
  let counts = count_books(books, [0, 0, 0, 0, 0])
  let #(price, _) = minimum_cost(counts, dict.new())
  price
}

fn count_books(books: List(Int), counts: List(Int)) -> List(Int) {
  case books {
    [] -> counts
    [book, ..rest] -> count_books(rest, increment(counts, book - 1))
  }
}

fn increment(counts: List(Int), index: Int) -> List(Int) {
  case counts {
    [] -> []
    [count, ..rest] ->
      case index {
        0 -> [count + 1, ..rest]
        _ -> [count, ..increment(rest, index - 1)]
      }
  }
}

fn minimum_cost(counts: List(Int), memo: Dict(List(Int), Float)) -> #(Float, Dict(List(Int), Float)) {
  case dict.get(memo, counts) {
    Ok(price) -> #(price, memo)
    Error(_) -> {
      let #(price, updated_memo) =
        case total(counts) {
          0 -> #(0.0, memo)
          _ -> best_group(groups(counts, 1, []), counts, memo, 1_000_000_000.0)
        }
      #(price, dict.insert(updated_memo, counts, price))
    }
  }
}

fn groups(counts: List(Int), index: Int, selected: List(Int)) -> List(List(Int)) {
  case counts {
    [] ->
      case selected {
        [] -> []
        _ -> [reverse(selected, [])]
      }
    [count, ..rest] -> {
      let skipped = groups(rest, index + 1, selected)
      case count > 0 {
        True -> list.append(groups(rest, index + 1, [index, ..selected]), skipped)
        False -> skipped
      }
    }
  }
}

fn best_group(
  options: List(List(Int)),
  counts: List(Int),
  memo: Dict(List(Int), Float),
  best: Float,
) -> #(Float, Dict(List(Int), Float)) {
  case options {
    [] -> #(best, memo)
    [group, ..rest] -> {
      let remaining = decrement(counts, group, 1)
      let #(remaining_cost, updated_memo) = minimum_cost(remaining, memo)
      let price = group_price(list.length(group)) +. remaining_cost
      let new_best =
        case price < best {
          True -> price
          False -> best
        }
      best_group(rest, counts, updated_memo, new_best)
    }
  }
}

fn decrement(counts: List(Int), selected: List(Int), index: Int) -> List(Int) {
  case counts {
    [] -> []
    [count, ..rest] -> {
      let new_count =
        case contains(selected, index) {
          True -> count - 1
          False -> count
        }
      [new_count, ..decrement(rest, selected, index + 1)]
    }
  }
}

fn contains(values: List(Int), target: Int) -> Bool {
  case values {
    [] -> False
    [value, ..rest] -> value == target || contains(rest, target)
  }
}

fn total(values: List(Int)) -> Int {
  case values {
    [] -> 0
    [value, ..rest] -> value + total(rest)
  }
}

fn group_price(size: Int) -> Float {
  case size {
    1 -> 800.0
    2 -> 1520.0
    3 -> 2160.0
    4 -> 2560.0
    5 -> 3000.0
    _ -> 0.0
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
