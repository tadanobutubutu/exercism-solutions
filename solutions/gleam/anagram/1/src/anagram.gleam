import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let normalized_word = string.lowercase(word)
  let target_letters = sorted_letters(normalized_word)

  list.filter(candidates, fn(candidate) {
    let normalized_candidate = string.lowercase(candidate)
    normalized_candidate != normalized_word
      && sorted_letters(normalized_candidate) == target_letters
  })
}

fn sorted_letters(word: String) -> List(String) {
  word
  |> string.to_graphemes
  |> list.sort(by: string.compare)
}
