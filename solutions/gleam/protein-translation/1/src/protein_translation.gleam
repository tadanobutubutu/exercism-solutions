import gleam/list
import gleam/string

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  translate_codons(string.to_graphemes(rna), [])
}

fn translate_codons(codons: List(String), reversed: List(String)) -> Result(List(String), Nil) {
  case codons {
    [] -> Ok(list.reverse(reversed))
    [first, second, third, ..rest] -> {
      let codon = first <> second <> third
      case codon {
        "UAA" | "UAG" | "UGA" -> Ok(list.reverse(reversed))
        "AUG" -> translate_codons(rest, ["Methionine", ..reversed])
        "UUU" | "UUC" -> translate_codons(rest, ["Phenylalanine", ..reversed])
        "UUA" | "UUG" -> translate_codons(rest, ["Leucine", ..reversed])
        "UCU" | "UCC" | "UCA" | "UCG" -> translate_codons(rest, ["Serine", ..reversed])
        "UAU" | "UAC" -> translate_codons(rest, ["Tyrosine", ..reversed])
        "UGU" | "UGC" -> translate_codons(rest, ["Cysteine", ..reversed])
        "UGG" -> translate_codons(rest, ["Tryptophan", ..reversed])
        _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
