import gleam/string

pub fn score(word: String) -> Int {
  score_letters(string.to_graphemes(string.lowercase(word)), 0)
}

fn score_letters(letters: List(String), total: Int) -> Int {
  case letters {
    [] -> total
    [letter, ..rest] -> score_letters(rest, total + letter_score(letter))
  }
}

fn letter_score(letter: String) -> Int {
  case letter {
    "a" | "e" | "i" | "o" | "u" | "l" | "n" | "r" | "s" | "t" -> 1
    "d" | "g" -> 2
    "b" | "c" | "m" | "p" -> 3
    "f" | "h" | "v" | "w" | "y" -> 4
    "k" -> 5
    "j" | "x" -> 8
    "q" | "z" -> 10
    _ -> 0
  }
}
