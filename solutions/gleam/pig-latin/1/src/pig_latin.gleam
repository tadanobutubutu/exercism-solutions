import gleam/list
import gleam/string

pub fn translate(phrase: String) -> String {
  translate_words(string.split(phrase, on: " "))
}

fn translate_words(words: List(String)) -> String {
  case words {
    [] -> ""
    [word] -> translate_word(word)
    [word, ..rest] -> translate_word(word) <> " " <> translate_words(rest)
  }
}

fn translate_word(word: String) -> String {
  let letters = string.to_graphemes(word)
  case letters {
    ["a", ..] | ["e", ..] | ["i", ..] | ["o", ..] | ["u", ..] -> word <> "ay"
    ["x", "r", ..] | ["y", "t", ..] -> word <> "ay"
    [] -> ""
    _ -> move_onset(letters, [])
  }
}

fn move_onset(letters: List(String), prefix_reversed: List(String)) -> String {
  case letters {
    [] -> string.concat(list.reverse(prefix_reversed)) <> "ay"
    ["q", "u", ..rest] ->
      string.concat(rest) <> "qu" <> string.concat(list.reverse(prefix_reversed)) <> "ay"
    [letter, ..]
    if is_vowel(letter) || (letter == "y" && prefix_reversed != []) ->
      string.concat(letters)
      <> string.concat(list.reverse(prefix_reversed))
      <> "ay"
    [letter, ..rest] -> move_onset(rest, [letter, ..prefix_reversed])
  }
}

fn is_vowel(letter: String) -> Bool {
  letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"
}
