import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/string

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

type Instruction {
  Push(Int)
  Operation(String)
}

pub opaque type Forth {
  Forth(stack: List(Int), words: Dict(String, List(Instruction)))
}

pub fn new() -> Forth {
  Forth(stack: [], words: dict.new())
}

pub fn format_stack(f: Forth) -> String {
  case f {
    Forth(stack, _) -> stack |> list.reverse |> list.map(int.to_string) |> string.join(" ")
  }
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  case f {
    Forth(stack, words) -> {
      let tokens = prog |> string.lowercase |> string.split(on: " ") |> non_empty_tokens([])
      run_source(tokens, stack, words)
    }
  }
}

fn run_source(
  tokens: List(String),
  stack: List(Int),
  words: Dict(String, List(Instruction)),
) -> Result(Forth, ForthError) {
  case tokens {
    [] -> Ok(Forth(stack, words))
    [":", ..rest] -> define_word(rest, stack, words)
    [token, ..rest] -> case dict.get(words, token) {
      Ok(instructions) -> case run_instructions(instructions, stack) {
        Error(error) -> Error(error)
        Ok(updated_stack) -> run_source(rest, updated_stack, words)
      }
      Error(_) -> case int.parse(token) {
        Ok(number) -> run_source(rest, [number, ..stack], words)
        Error(_) -> case is_builtin(token) {
          True -> case apply_operation(token, stack) {
            Error(error) -> Error(error)
            Ok(updated_stack) -> run_source(rest, updated_stack, words)
          }
          False -> Error(UnknownWord)
        }
      }
    }
  }
}

fn define_word(
  tokens: List(String),
  stack: List(Int),
  words: Dict(String, List(Instruction)),
) -> Result(Forth, ForthError) {
  case tokens {
    [name, ..body_and_rest] -> case int.parse(name) {
      Ok(_) -> Error(InvalidWord)
      Error(_) -> case take_definition_body(body_and_rest, []) {
        None -> Error(InvalidWord)
        Some(#(body, remaining)) -> case compile_body(body, words, []) {
          Error(error) -> Error(error)
          Ok(instructions) -> run_source(remaining, stack, dict.insert(words, name, instructions))
        }
      }
    }
    [] -> Error(InvalidWord)
  }
}

fn take_definition_body(
  tokens: List(String),
  reversed_body: List(String),
) -> Option(#(List(String), List(String))) {
  case tokens {
    [] -> None
    [";", ..rest] -> Some(#(list.reverse(reversed_body), rest))
    [token, ..rest] -> take_definition_body(rest, [token, ..reversed_body])
  }
}

fn compile_body(
  tokens: List(String),
  words: Dict(String, List(Instruction)),
  compiled: List(Instruction),
) -> Result(List(Instruction), ForthError) {
  case tokens {
    [] -> Ok(compiled)
    [token, ..rest] -> case dict.get(words, token) {
      Ok(instructions) -> compile_body(rest, words, list.append(compiled, instructions))
      Error(_) -> case int.parse(token) {
        Ok(number) -> compile_body(rest, words, list.append(compiled, [Push(number)]))
        Error(_) -> case is_builtin(token) {
          True -> compile_body(rest, words, list.append(compiled, [Operation(token)]))
          False -> Error(UnknownWord)
        }
      }
    }
  }
}

fn run_instructions(
  instructions: List(Instruction),
  stack: List(Int),
) -> Result(List(Int), ForthError) {
  case instructions {
    [] -> Ok(stack)
    [Push(number), ..rest] -> run_instructions(rest, [number, ..stack])
    [Operation(operation), ..rest] -> case apply_operation(operation, stack) {
      Error(error) -> Error(error)
      Ok(updated_stack) -> run_instructions(rest, updated_stack)
    }
  }
}

fn apply_operation(operation: String, stack: List(Int)) -> Result(List(Int), ForthError) {
  case operation {
    "+" -> case stack {
      [right, left, ..rest] -> Ok([left + right, ..rest])
      _ -> Error(StackUnderflow)
    }
    "-" -> case stack {
      [right, left, ..rest] -> Ok([left - right, ..rest])
      _ -> Error(StackUnderflow)
    }
    "*" -> case stack {
      [right, left, ..rest] -> Ok([left * right, ..rest])
      _ -> Error(StackUnderflow)
    }
    "/" -> case stack {
      [0, _left, .._] -> Error(DivisionByZero)
      [right, left, ..rest] -> Ok([left / right, ..rest])
      _ -> Error(StackUnderflow)
    }
    "dup" -> case stack {
      [top, ..rest] -> Ok([top, top, ..rest])
      _ -> Error(StackUnderflow)
    }
    "drop" -> case stack {
      [_top, ..rest] -> Ok(rest)
      _ -> Error(StackUnderflow)
    }
    "swap" -> case stack {
      [top, second, ..rest] -> Ok([second, top, ..rest])
      _ -> Error(StackUnderflow)
    }
    "over" -> case stack {
      [top, second, ..rest] -> Ok([second, top, second, ..rest])
      _ -> Error(StackUnderflow)
    }
    _ -> Error(UnknownWord)
  }
}

fn is_builtin(token: String) -> Bool {
  case token {
    "+" | "-" | "*" | "/" | "dup" | "drop" | "swap" | "over" -> True
    _ -> False
  }
}

fn non_empty_tokens(tokens: List(String), result: List(String)) -> List(String) {
  case tokens {
    [] -> list.reverse(result)
    [token, ..rest] -> case string.trim(token) == "" {
      True -> non_empty_tokens(rest, result)
      False -> non_empty_tokens(rest, [string.trim(token), ..result])
    }
  }
}
