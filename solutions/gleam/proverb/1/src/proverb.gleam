pub fn recite(inputs: List(String)) -> String {
  case inputs {
    [] -> ""
    [first, ..] -> {
      let lines = build_transitions(inputs, "")
      append_line(lines, "And all for the want of a " <> first <> ".")
    }
  }
}

fn build_transitions(inputs: List(String), lines: String) -> String {
  case inputs {
    [first, second, ..rest] -> {
      let line = "For want of a " <> first <> " the " <> second <> " was lost."
      build_transitions([second, ..rest], append_line(lines, line))
    }
    _ -> lines
  }
}

fn append_line(existing: String, line: String) -> String {
  case existing {
    "" -> line
    _ -> existing <> "\n" <> line
  }
}
