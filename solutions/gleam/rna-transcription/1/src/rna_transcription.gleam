import gleam/list
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  case transcribe(string.to_graphemes(dna), []) {
    Ok(reversed) -> Ok(reversed |> list.reverse |> string.concat)
    Error(Nil) -> Error(Nil)
  }
}

fn transcribe(dna: List(String), reversed: List(String)) -> Result(List(String), Nil) {
  case dna {
    [] -> Ok(reversed)
    ["G", ..rest] -> transcribe(rest, ["C", ..reversed])
    ["C", ..rest] -> transcribe(rest, ["G", ..reversed])
    ["T", ..rest] -> transcribe(rest, ["A", ..reversed])
    ["A", ..rest] -> transcribe(rest, ["U", ..reversed])
    [_, ..] -> Error(Nil)
  }
}
