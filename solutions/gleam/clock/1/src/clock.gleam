import gleam/int

pub type Clock {
  Clock(minutes: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  Clock(normalize(hour * 60 + minute))
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes + minutes))
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes - minutes))
}

pub fn display(clock: Clock) -> String {
  let hour = clock.minutes / 60
  let minute = clock.minutes % 60
  two_digits(hour) <> ":" <> two_digits(minute)
}

fn normalize(minutes: Int) -> Int {
  let remainder = minutes % 1440
  case remainder {
    value if value < 0 -> value + 1440
    _ -> remainder
  }
}

fn two_digits(value: Int) -> String {
  let digits = int.to_string(value)
  case value < 10 {
    True -> "0" <> digits
    False -> digits
  }
}
