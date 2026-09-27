import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let actions =
    []
    |> append_if(encoded_message % 2 == 1, Wink)
    |> append_if(encoded_message / 2 % 2 == 1, DoubleBlink)
    |> append_if(encoded_message / 4 % 2 == 1, CloseYourEyes)
    |> append_if(encoded_message / 8 % 2 == 1, Jump)

  case encoded_message / 16 % 2 {
    1 -> list.reverse(actions)
    _ -> actions
  }
}

fn append_if(actions: List(Command), enabled: Bool, command: Command) -> List(Command) {
  case enabled {
    True -> list.append(actions, [command])
    False -> actions
  }
}
