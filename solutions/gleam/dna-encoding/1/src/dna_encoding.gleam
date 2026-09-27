pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  case dna {
    [] -> <<>>
    [nucleotide, ..rest] -> {
      let code = encode_nucleotide(nucleotide)
      let rest = encode(rest)
      <<code:2, rest:bits>>
    }
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<>> -> Ok([])
    <<code:2, rest:bits>> ->
      case decode_nucleotide(code) {
        Ok(nucleotide) ->
          case decode(rest) {
            Ok(nucleotides) -> Ok([nucleotide, ..nucleotides])
            Error(Nil) -> Error(Nil)
          }
        Error(Nil) -> Error(Nil)
      }
    _ -> Error(Nil)
  }
}
