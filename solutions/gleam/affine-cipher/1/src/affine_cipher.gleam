import gleam/list
import gleam/string

pub type Error {
  KeyNotCoprime(Int, Int)
}

pub fn encode(
  plaintext plaintext: String,
  a a: Int,
  b b: Int,
) -> Result(String, Error) {
  case gcd(absolute(a), 26) == 1 {
    False -> Error(KeyNotCoprime(a, 26))
    True -> {
      let encoded = encode_chars(string.to_graphemes(string.lowercase(plaintext)), a, b, 0, "")
      Ok(encoded)
    }
  }
}

pub fn decode(
  ciphertext ciphertext: String,
  a a: Int,
  b b: Int,
) -> Result(String, Error) {
  case gcd(absolute(a), 26) == 1 {
    False -> Error(KeyNotCoprime(a, 26))
    True -> {
      let inverse = modular_inverse(a, 1)
      Ok(decode_chars(string.to_graphemes(string.lowercase(ciphertext)), inverse, b, ""))
    }
  }
}

fn encode_chars(
  characters: List(String),
  a: Int,
  b: Int,
  count: Int,
  result: String,
) -> String {
  case characters {
    [] -> result
    [character, ..rest] -> {
      let encoded = case letter_index(character) {
        Some(index) -> at(alphabet(), modulo(a * index + b, 26))
        None -> case is_digit(character) {
          True -> character
          False -> ""
        }
      }
      case encoded == "" {
        True -> encode_chars(rest, a, b, count, result)
        False -> {
          let separator = case count > 0 && count % 5 == 0 {
            True -> " "
            False -> ""
          }
          encode_chars(rest, a, b, count + 1, result <> separator <> encoded)
        }
      }
    }
  }
}

fn decode_chars(
  characters: List(String),
  inverse: Int,
  b: Int,
  result: String,
) -> String {
  case characters {
    [] -> result
    [character, ..rest] -> {
      let decoded = case letter_index(character) {
        Some(index) -> at(alphabet(), modulo(inverse * (index - b), 26))
        None -> case is_digit(character) {
          True -> character
          False -> ""
        }
      }
      decode_chars(rest, inverse, b, result <> decoded)
    }
  }
}

fn alphabet() -> List(String) {
  string.to_graphemes("abcdefghijklmnopqrstuvwxyz")
}

fn letter_index(letter: String) -> Option(Int) {
  find_index(alphabet(), letter, 0)
}

fn find_index(characters: List(String), target: String, index: Int) -> Option(Int) {
  case characters {
    [] -> None
    [character, ..rest] -> case character == target {
      True -> Some(index)
      False -> find_index(rest, target, index + 1)
    }
  }
}

fn is_digit(character: String) -> Bool {
  character >= "0" && character <= "9"
}

fn at(characters: List(String), index: Int) -> String {
  case list.drop(characters, index) {
    [character, .._] -> character
    [] -> ""
  }
}

fn modulo(value: Int, divisor: Int) -> Int {
  (value % divisor + divisor) % divisor
}

fn absolute(value: Int) -> Int {
  case value < 0 {
    True -> 0 - value
    False -> value
  }
}

fn gcd(left: Int, right: Int) -> Int {
  case right == 0 {
    True -> left
    False -> gcd(right, left % right)
  }
}

fn modular_inverse(value: Int, candidate: Int) -> Int {
  case modulo(value * candidate, 26) == 1 {
    True -> candidate
    False -> modular_inverse(value, candidate + 1)
  }
}
