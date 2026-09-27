import gleam/string

pub fn first_letter(name: String) -> String {
  case string.to_graphemes(string.trim(name)) {
    [letter, ..] -> letter
    [] -> ""
  }
}

pub fn initial(name: String) -> String {
  string.uppercase(first_letter(name)) <> "."
}

pub fn initials(full_name: String) -> String {
  case string.split(string.trim(full_name), on: " ") {
    [first_name, last_name] -> initial(first_name) <> " " <> initial(last_name)
    _ -> ""
  }
}

pub fn pair(full_name1: String, full_name2: String) -> String {
  //      ******       ******
  //    **      **   **      **
  //  **         ** **         **
  // **            *            **
  // **                         **
  // **     X. X.  +  X. X.     **
  //  **                       **
  //    **                   **
  //      **               **
  //        **           **
  //          **       **
  //            **   **
  //              ***
  //               *
  "\n     ******       ******\n"
  <> "   **      **   **      **\n"
  <> " **         ** **         **\n"
  <> "**            *            **\n"
  <> "**                         **\n"
  <> "**     "
  <> initials(full_name1)
  <> "  +  "
  <> initials(full_name2)
  <> "     **\n"
  <> " **                       **\n"
  <> "   **                   **\n"
  <> "     **               **\n"
  <> "       **           **\n"
  <> "         **       **\n"
  <> "           **   **\n"
  <> "             ***\n"
  <> "              *\n"
}
