defmodule VariableLengthQuantity do
  import Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.flat_map(&encode_integer/1)
    |> Enum.into(<<>>, fn byte -> <<byte>> end)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    decode_bytes(bytes, 0, false, [])
  end

  defp encode_integer(0), do: [0]

  defp encode_integer(integer) when integer > 0 do
    chunks = do_encode(integer, [])

    chunks
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      if index < length(chunks) - 1, do: value + 0x80, else: value
    end)
  end

  defp do_encode(integer, chunks) when integer < 128, do: [integer | chunks]

  defp do_encode(integer, chunks) do
    do_encode(div(integer, 128), [rem(integer, 128) | chunks])
  end

  defp decode_bytes(<<>>, _value, true, _decoded), do: {:error, "incomplete sequence"}
  defp decode_bytes(<<>>, _value, false, decoded), do: {:ok, Enum.reverse(decoded)}

  defp decode_bytes(<<byte, rest::binary>>, value, _in_sequence, decoded) do
    payload = band(byte, 0x7F)
    next_value = value * 128 + payload

    if band(byte, 0x80) != 0 do
      decode_bytes(rest, next_value, true, decoded)
    else
      decode_bytes(rest, 0, false, [next_value | decoded])
    end
  end
end
