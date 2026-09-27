import gleam/string

pub fn message(log_line: String) -> String {
  case string.split(log_line, on: "]: ") {
    [_, message] -> string.trim(message)
    _ -> ""
  }
}

pub fn log_level(log_line: String) -> String {
  case string.split(log_line, on: "]: ") {
    [level, _] ->
      case level {
        "[" <> value -> string.lowercase(value)
        _ -> ""
      }
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
