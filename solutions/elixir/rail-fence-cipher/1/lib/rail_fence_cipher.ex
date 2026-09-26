defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    chars = String.graphemes(str)
    indices = rail_indices(length(chars), rails)
    row_count = min(rails, length(chars))

    if row_count == 0 do
      ""
    else
      rows = List.duplicate([], row_count)

      chars
      |> Enum.zip(indices)
      |> Enum.reduce(rows, fn {char, rail}, rows ->
        List.update_at(rows, rail, &[char | &1])
      end)
      |> Enum.map(&(&1 |> Enum.reverse() |> Enum.join()))
      |> Enum.join()
    end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    chars = String.graphemes(str)
    indices = rail_indices(length(chars), rails)
    row_count = min(rails, length(chars))

    if row_count == 0 do
      ""
    else
      {rows, _remaining} =
        Enum.map_reduce(0..(row_count - 1), chars, fn rail, remaining ->
          row_length = Enum.count(indices, &(&1 == rail))
          Enum.split(remaining, row_length)
        end)

      {decoded, _positions} =
        Enum.map_reduce(indices, List.duplicate(0, row_count), fn rail, positions ->
          position = Enum.at(positions, rail)
          char = rows |> Enum.at(rail) |> Enum.at(position)
          {char, List.update_at(positions, rail, &(&1 + 1))}
        end)

      Enum.join(decoded)
    end
  end

  defp rail_indices(0, _rails), do: []
  defp rail_indices(length, rails) when rails <= 1, do: List.duplicate(0, length)

  defp rail_indices(length, rails) do
    Enum.map_reduce(0..(length - 1), {0, 1}, fn _, {rail, direction} ->
      next_state =
        cond do
          rail == 0 -> {1, 1}
          rail == rails - 1 -> {rail - 1, -1}
          true -> {rail + direction, direction}
        end

      {rail, next_state}
    end)
    |> elem(0)
  end
end
