import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn solve(puzzle: String) -> Result(Dict(String, Int), Nil) {
  case string.split(puzzle, on: " == ") {
    [left, right] -> {
      let words = string.split(left, on: " + ")
      let addends = list.map(words, fn(word) { word |> string.to_graphemes |> list.reverse })
      let result = right |> string.to_graphemes |> list.reverse
      let all_words = list.append(words, [right])
      let leading = leading_letters(all_words, [])
      let letters = unique_letters(string.to_graphemes(string.concat(all_words)), [])
      let max_columns = max_word_length(all_words, 0)
      case list.length(letters) > 10 {
        True -> Error(Nil)
        False -> case solve_columns(addends, result, 0, 0, [], [], leading, max_columns) {
          Some(solution) -> Ok(dict.from_list(solution))
          None -> Error(Nil)
        }
      }
    }
    _ -> Error(Nil)
  }
}

fn solve_columns(
  addends: List(List(String)),
  result: List(String),
  column: Int,
  carry: Int,
  mapping: List(#(String, Int)),
  used_digits: List(Int),
  leading: List(String),
  max_columns: Int,
) -> Option(List(#(String, Int))) {
  case column >= max_columns {
    True -> case carry == 0 {
      True -> Some(mapping)
      False -> None
    }
    False -> assign_addends(
      addends,
      addends,
      result,
      column,
      carry,
      0,
      mapping,
      used_digits,
      leading,
      max_columns,
    )
  }
}

fn assign_addends(
  all_addends: List(List(String)),
  remaining_addends: List(List(String)),
  result: List(String),
  column: Int,
  carry: Int,
  sum: Int,
  mapping: List(#(String, Int)),
  used_digits: List(Int),
  leading: List(String),
  max_columns: Int,
) -> Option(List(#(String, Int))) {
  case remaining_addends {
    [] -> finish_column(
      result,
      column,
      carry + sum,
      mapping,
      used_digits,
      leading,
      all_addends,
      max_columns,
    )
    [word, ..rest] -> case char_at(word, column) {
      None -> assign_addends(
        all_addends,
        rest,
        result,
        column,
        carry,
        sum,
        mapping,
        used_digits,
        leading,
        max_columns,
      )
      Some(letter) -> case mapped_value(mapping, letter) {
        Some(digit) -> assign_addends(
          all_addends,
          rest,
          result,
          column,
          carry,
          sum + digit,
          mapping,
          used_digits,
          leading,
          max_columns,
        )
        None -> try_digit(
          0,
          letter,
          all_addends,
          rest,
          result,
          column,
          carry,
          sum,
          mapping,
          used_digits,
          leading,
          max_columns,
        )
      }
    }
  }
}

fn try_digit(
  digit: Int,
  letter: String,
  all_addends: List(List(String)),
  remaining_addends: List(List(String)),
  result: List(String),
  column: Int,
  carry: Int,
  sum: Int,
  mapping: List(#(String, Int)),
  used_digits: List(Int),
  leading: List(String),
  max_columns: Int,
) -> Option(List(#(String, Int))) {
  case digit > 9 {
    True -> None
    False -> case contains_int(used_digits, digit) || (digit == 0 && contains_string(leading, letter)) {
      True -> try_digit(
        digit + 1,
        letter,
        all_addends,
        remaining_addends,
        result,
        column,
        carry,
        sum,
        mapping,
        used_digits,
        leading,
        max_columns,
      )
      False -> {
        let updated_mapping = [#(letter, digit), ..mapping]
        let updated_digits = [digit, ..used_digits]
        case assign_addends(
          all_addends,
          remaining_addends,
          result,
          column,
          carry,
          sum + digit,
          updated_mapping,
          updated_digits,
          leading,
          max_columns,
        ) {
          Some(solution) -> Some(solution)
          None -> try_digit(
            digit + 1,
            letter,
            all_addends,
            remaining_addends,
            result,
            column,
            carry,
            sum,
            mapping,
            used_digits,
            leading,
            max_columns,
          )
        }
      }
    }
  }
}

fn finish_column(
  result: List(String),
  column: Int,
  total: Int,
  mapping: List(#(String, Int)),
  used_digits: List(Int),
  leading: List(String),
  addends: List(List(String)),
  max_columns: Int,
) -> Option(List(#(String, Int))) {
  let digit = total % 10
  let next_carry = total / 10
  case char_at(result, column) {
    None -> case digit == 0 {
      True -> solve_columns(addends, result, column + 1, next_carry, mapping, used_digits, leading, max_columns)
      False -> None
    }
    Some(letter) -> case mapped_value(mapping, letter) {
      Some(existing) -> case existing == digit {
        True -> solve_columns(addends, result, column + 1, next_carry, mapping, used_digits, leading, max_columns)
        False -> None
      }
      None -> case contains_int(used_digits, digit) || (digit == 0 && contains_string(leading, letter)) {
        True -> None
        False -> solve_columns(
          addends,
          result,
          column + 1,
          next_carry,
          [#(letter, digit), ..mapping],
          [digit, ..used_digits],
          leading,
          max_columns,
        )
      }
    }
  }
}

fn char_at(characters: List(String), index: Int) -> Option(String) {
  case list.drop(characters, index) {
    [character, .._] -> Some(character)
    [] -> None
  }
}

fn mapped_value(mapping: List(#(String, Int)), letter: String) -> Option(Int) {
  case mapping {
    [] -> None
    [#(key, value), ..rest] -> case key == letter {
      True -> Some(value)
      False -> mapped_value(rest, letter)
    }
  }
}

fn contains_int(values: List(Int), target: Int) -> Bool {
  case values {
    [] -> False
    [value, ..rest] -> value == target || contains_int(rest, target)
  }
}

fn contains_string(values: List(String), target: String) -> Bool {
  case values {
    [] -> False
    [value, ..rest] -> value == target || contains_string(rest, target)
  }
}

fn leading_letters(words: List(String), result: List(String)) -> List(String) {
  case words {
    [] -> result
    [word, ..rest] -> case string.to_graphemes(word) {
      [first, _second, .._] -> leading_letters(rest, [first, ..result])
      _ -> leading_letters(rest, result)
    }
  }
}

fn unique_letters(letters: List(String), seen: List(String)) -> List(String) {
  case letters {
    [] -> seen
    [letter, ..rest] -> case contains_string(seen, letter) {
      True -> unique_letters(rest, seen)
      False -> unique_letters(rest, [letter, ..seen])
    }
  }
}

fn max_word_length(words: List(String), maximum: Int) -> Int {
  case words {
    [] -> maximum
    [word, ..rest] -> max_word_length(rest, int_max(maximum, string.length(word)))
  }
}

fn int_max(left: Int, right: Int) -> Int {
  case left > right {
    True -> left
    False -> right
  }
}
