import gleam/int
import gleam/list
import gleam/string

pub type Error {
  SyntaxError
  UnknownOperation
  ImpossibleOperation
}

pub fn answer(question: String) -> Result(Int, Error) {
  case string.split(string.trim(question), on: "What is") {
    ["", body] -> {
      let expression = body |> string.split(on: "?") |> first_or_empty |> string.trim
      let tokens = expression |> string.split(on: " ") |> non_empty_tokens([])
      parse_expression(tokens)
    }
    _ -> Error(UnknownOperation)
  }
}

fn parse_expression(tokens: List(String)) -> Result(Int, Error) {
  case tokens {
    [] -> Error(SyntaxError)
    [first, ..rest] -> case int.parse(first) {
      Error(_) -> Error(UnknownOperation)
      Ok(value) -> parse_operations(rest, value)
    }
  }
}

fn parse_operations(tokens: List(String), value: Int) -> Result(Int, Error) {
  case tokens {
    [] -> Ok(value)
    [operator, ..rest] -> case parse_operator(operator, rest) {
      Error(error) -> Error(error)
      Ok(#(operation, after_operator)) -> case after_operator {
        [] -> Error(SyntaxError)
        [operand, ..remaining] -> case int.parse(operand) {
          Error(_) -> Error(SyntaxError)
          Ok(right) -> case apply(operation, value, right) {
            Error(error) -> Error(error)
            Ok(result) -> parse_operations(remaining, result)
          }
        }
      }
    }
  }
}

fn parse_operator(operator: String, rest: List(String)) -> Result(#(String, List(String)), Error) {
  case operator {
    "plus" -> Ok(#("plus", rest))
    "minus" -> Ok(#("minus", rest))
    "multiplied" -> case rest {
      ["by", ..remaining] -> Ok(#("multiplied", remaining))
      _ -> Error(UnknownOperation)
    }
    "divided" -> case rest {
      ["by", ..remaining] -> Ok(#("divided", remaining))
      _ -> Error(UnknownOperation)
    }
    _ -> case int.parse(operator) {
      Ok(_) -> Error(SyntaxError)
      Error(_) -> Error(UnknownOperation)
    }
  }
}

fn apply(operation: String, left: Int, right: Int) -> Result(Int, Error) {
  case operation {
    "plus" -> Ok(left + right)
    "minus" -> Ok(left - right)
    "multiplied" -> Ok(left * right)
    "divided" -> case right == 0 {
      True -> Error(ImpossibleOperation)
      False -> Ok(left / right)
    }
    _ -> Error(UnknownOperation)
  }
}

fn first_or_empty(values: List(String)) -> String {
  case values {
    [first, .._] -> first
    [] -> ""
  }
}

fn non_empty_tokens(tokens: List(String), result: List(String)) -> List(String) {
  case tokens {
    [] -> list.reverse(result)
    [token, ..rest] -> {
      let trimmed = string.trim(token)
      case trimmed == "" {
        True -> non_empty_tokens(rest, result)
        False -> non_empty_tokens(rest, [trimmed, ..result])
      }
    }
  }
}
