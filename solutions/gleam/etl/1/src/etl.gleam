import gleam/dict.{type Dict}
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  transform_groups(dict.to_list(legacy), dict.new())
}

fn transform_groups(
  groups: List(#(Int, List(String))),
  transformed: Dict(String, Int),
) -> Dict(String, Int) {
  case groups {
    [] -> transformed
    [#(score, letters), ..rest] ->
      transform_groups(rest, transform_letters(letters, score, transformed))
  }
}

fn transform_letters(
  letters: List(String),
  score: Int,
  transformed: Dict(String, Int),
) -> Dict(String, Int) {
  case letters {
    [] -> transformed
    [letter, ..rest] ->
      transform_letters(
        rest,
        score,
        dict.insert(transformed, string.lowercase(letter), score),
      )
  }
}
