pub type Error {
  IncompleteSequence
}

pub fn encode(integers: List(Int)) -> BitArray {
  encode_values(integers, <<>>)
}

pub fn decode(string: BitArray) -> Result(List(Int), Error) {
  decode_bytes(string, 0, False, [])
}

fn encode_values(values: List(Int), result: BitArray) -> BitArray {
  case values {
    [] -> result
    [value, ..rest] ->
      encode_values(rest, append_bytes(result, encode_integer(value)))
  }
}

fn encode_integer(value: Int) -> BitArray {
  let chunks = integer_chunks(value, [])
  encode_chunks(chunks, <<>>)
}

fn integer_chunks(value: Int, chunks: List(Int)) -> List(Int) {
  case value < 128 {
    True -> [value, ..chunks]
    False -> integer_chunks(value / 128, [value % 128, ..chunks])
  }
}

fn encode_chunks(chunks: List(Int), result: BitArray) -> BitArray {
  case chunks {
    [] -> result
    [last] -> <<result:bits, last:8>>
    [chunk, ..rest] -> encode_chunks(rest, <<result:bits, (chunk + 128):8>>)
  }
}

fn append_bytes(first: BitArray, second: BitArray) -> BitArray {
  <<first:bits, second:bits>>
}

fn decode_bytes(
  bytes: BitArray,
  value: Int,
  continued: Bool,
  result: List(Int),
) -> Result(List(Int), Error) {
  case bytes {
    <<>> ->
      case continued {
        True -> Error(IncompleteSequence)
        False -> Ok(reverse(result, []))
      }
    <<byte:8, rest:bits>> -> {
      let accumulated = value * 128 + byte % 128
      case byte >= 128 {
        True -> decode_bytes(rest, accumulated, True, result)
        False -> decode_bytes(rest, 0, False, [accumulated, ..result])
      }
    }
    _ -> Error(IncompleteSequence)
  }
}

fn reverse(values: List(Int), result: List(Int)) -> List(Int) {
  case values {
    [] -> result
    [value, ..rest] -> reverse(rest, [value, ..result])
  }
}
