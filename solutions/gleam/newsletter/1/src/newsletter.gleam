import gleam/list
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(contents) -> {
      let emails =
        contents
        |> string.split(on: "\n")
        |> list.map(fn(email) { string.trim(email) })
        |> list.filter(fn(email) { email != "" })
      Ok(emails)
    }
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.write(path, "") {
    Ok(Nil) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(path, email <> "\n") {
    Ok(Nil) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case read_emails(emails_path) {
    Ok(emails) -> send_emails(emails, log_path, send_email)
    Error(Nil) -> Error(Nil)
  }
}

fn send_emails(
  emails: List(String),
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case emails {
    [] -> Ok(Nil)
    [email, ..rest] ->
      case send_email(email) {
        Ok(Nil) ->
          case log_sent_email(log_path, email) {
            Ok(Nil) -> send_emails(rest, log_path, send_email)
            Error(Nil) -> Error(Nil)
          }
        Error(Nil) -> send_emails(rest, log_path, send_email)
      }
  }
}
