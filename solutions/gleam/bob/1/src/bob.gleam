import gleam/list
import gleam/string

pub fn hey(remark: String) -> String {
  let trimmed = string.trim(remark)
  let letters = string.to_graphemes(trimmed)
  let has_letters =
    list.any(letters, fn(letter) {
      string.lowercase(letter) != string.uppercase(letter)
    })
  let is_yelling = has_letters && string.uppercase(trimmed) == trimmed
  let is_question = case list.reverse(letters) {
    ["?", ..] -> True
    _ -> False
  }

  case #(trimmed == "", is_yelling, is_question) {
    #(True, _, _) -> "Fine. Be that way!"
    #(_, True, True) -> "Calm down, I know what I'm doing!"
    #(_, True, False) -> "Whoa, chill out!"
    #(_, False, True) -> "Sure."
    _ -> "Whatever."
  }
}
