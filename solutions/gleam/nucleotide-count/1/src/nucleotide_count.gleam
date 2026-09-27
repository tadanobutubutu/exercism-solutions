import gleam/dict.{type Dict}
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  let counts = dict.from_list([#("A", 0), #("C", 0), #("G", 0), #("T", 0)])
  count_nucleotides(string.to_graphemes(dna), counts)
}

fn count_nucleotides(
  nucleotides: List(String),
  counts: Dict(String, Int),
) -> Result(Dict(String, Int), Nil) {
  case nucleotides {
    [] -> Ok(counts)
    [nucleotide, ..rest] ->
      case dict.get(counts, nucleotide) {
        Ok(count) ->
          count_nucleotides(rest, dict.insert(counts, nucleotide, count + 1))
        Error(_) -> Error(Nil)
      }
  }
}
