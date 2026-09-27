import gleam/set.{type Set}
import gleam/list
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  let already_owned = set.contains(collection, card)
  #(already_owned, set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let possible =
    set.contains(collection, my_card) && !set.contains(collection, their_card)

  let updated = collection |> set.delete(my_card) |> set.insert(their_card)
  #(possible, updated)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [] -> []
    [first, ..rest] ->
      rest
      |> intersect_all(first)
      |> set.to_list
      |> list.sort(by: string.compare)
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  union_size(collections, set.new())
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, fn(card) {
    case card {
      "Shiny " <> _ -> True
      _ -> False
    }
  })
}

fn intersect_all(collections: List(Set(String)), common: Set(String)) -> Set(String) {
  case collections {
    [] -> common
    [collection, ..rest] ->
      intersect_all(rest, set.intersection(common, collection))
  }
}

fn union_size(collections: List(Set(String)), all_cards: Set(String)) -> Int {
  case collections {
    [] -> set.size(all_cards)
    [collection, ..rest] -> union_size(rest, set.union(all_cards, collection))
  }
}
