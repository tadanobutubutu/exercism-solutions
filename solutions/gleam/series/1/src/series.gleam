import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let characters = string.to_graphemes(input)
  case size {
    value if value < 0 -> Error(SliceLengthNegative)
    0 -> Error(SliceLengthZero)
    _ if characters == [] -> Error(EmptySeries)
    value if value > list.length(characters) -> Error(SliceLengthTooLarge)
    _ -> Ok(collect_slices(characters, size, []))
  }
}

pub type Error {
  SliceLengthNegative
  SliceLengthZero
  SliceLengthTooLarge
  EmptySeries
}

fn collect_slices(characters: List(String), size: Int, reversed: List(String)) -> List(String) {
  let window = list.take(characters, size)
  case list.length(window) == size {
    False -> list.reverse(reversed)
    True ->
      collect_slices(
        list.drop(characters, 1),
        size,
        [string.concat(window), ..reversed],
      )
  }
}
