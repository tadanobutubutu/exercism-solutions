pub type Usd

pub type Eur

pub type Jpy

pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  Money(amount: amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  Money(amount: amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  Money(amount: amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  Money(amount: sum_amount(prices, 0))
}

fn sum_amount(prices: List(Money(currency)), total: Int) -> Int {
  case prices {
    [] -> total
    [Money(amount: amount), ..rest] -> sum_amount(rest, total + amount)
  }
}
