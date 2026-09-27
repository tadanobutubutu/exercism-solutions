import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(base) -> pizza_price(base) + 1
    ExtraToppings(base) -> pizza_price(base) + 2
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let delivery_fee = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }

  order_total(order, delivery_fee)
}

fn order_total(order: List(Pizza), total: Int) -> Int {
  case order {
    [] -> total
    [pizza, ..rest] -> order_total(rest, total + pizza_price(pizza))
  }
}
