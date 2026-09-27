pub fn egg_count(number: Int) -> Int {
  count_set_bits(number, 0)
}

fn count_set_bits(number: Int, count: Int) -> Int {
  case number {
    0 -> count
    _ -> count_set_bits(number / 2, count + number % 2)
  }
}
