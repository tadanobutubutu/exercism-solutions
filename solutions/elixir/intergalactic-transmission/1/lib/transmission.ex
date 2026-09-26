defmodule Transmission do
  import Bitwise

  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    message
    |> :binary.bin_to_list()
    |> Enum.flat_map(fn byte -> for shift <- 7..0//-1, do: band(bsr(byte, shift), 1) end)
    |> Enum.chunk_every(7)
    |> Enum.map(fn chunk ->
      padded = chunk ++ List.duplicate(0, 7 - length(chunk))
      payload = Enum.reduce(padded, 0, fn bit, acc -> acc * 2 + bit end)
      parity = rem(Enum.sum(padded), 2)
      (payload <<< 1) ||| parity
    end)
    |> :erlang.list_to_binary()
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
    bytes = :binary.bin_to_list(received_data)

    if Enum.any?(bytes, fn byte -> rem(byte |> Integer.digits(2) |> Enum.sum(), 2) != 0 end) do
      {:error, "wrong parity"}
    else
      bits =
        Enum.flat_map(bytes, fn byte ->
          payload = band(bsr(byte, 1), 0x7F)
          for shift <- 6..0//-1, do: band(bsr(payload, shift), 1)
        end)

      decoded =
        bits
        |> Enum.chunk_every(8)
        |> Enum.filter(&(length(&1) == 8))
        |> Enum.map(fn chunk -> Enum.reduce(chunk, 0, fn bit, acc -> acc * 2 + bit end) end)

      {:ok, :erlang.list_to_binary(decoded)}
    end
  end
end
