defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    normalized =
      str
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]/u, "")
      |> String.graphemes()

    length = length(normalized)

    if length == 0 do
      ""
    else
      columns = trunc(:math.ceil(:math.sqrt(length)))
      rows = div(length + columns - 1, columns)

      normalized
      |> Enum.chunk_every(columns)
      |> Enum.map(&Enum.take(&1 ++ List.duplicate(nil, columns - length(&1)), columns))
      |> transpose_columns(columns, rows)
      |> Enum.join(" ")
    end
  end

  defp transpose_columns(matrix, columns, rows) do
    for column <- 0..(columns - 1) do
      for row <- 0..(rows - 1) do
        case Enum.at(matrix, row) |> Enum.at(column) do
          nil -> " "
          character -> character
        end
      end
      |> Enum.join()
    end
  end
end
