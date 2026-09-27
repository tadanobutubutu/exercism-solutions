import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  (f -. 32.0) /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  let left_celsius = case left {
    Celsius(value) -> value
    Fahrenheit(value) -> fahrenheit_to_celsius(value)
  }
  let right_celsius = case right {
    Celsius(value) -> value
    Fahrenheit(value) -> fahrenheit_to_celsius(value)
  }

  float.compare(left_celsius, right_celsius)
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, by: fn(left, right) {
    compare_temperature(left.temperature, right.temperature)
  })
}
