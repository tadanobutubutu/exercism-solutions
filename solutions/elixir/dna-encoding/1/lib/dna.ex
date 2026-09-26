defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    encode(dna, <<>>)
  end

  def decode(dna) do
    dna
    |> decode([])
    |> Enum.reverse()
  end

  defp encode([], encoded), do: encoded

  defp encode([nucleotide | tail], encoded) do
    encode(tail, <<encoded::bitstring, encode_nucleotide(nucleotide)::4>>)
  end

  defp decode(<<>>, decoded), do: decoded

  defp decode(<<encoded_nucleotide::4, tail::bitstring>>, decoded) do
    decode(tail, [decode_nucleotide(encoded_nucleotide) | decoded])
  end
end
