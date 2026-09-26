defmodule WordSearch do
  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do
    rows =
      grid
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.trim(&1) |> String.graphemes()))

    height = length(rows)
    width = rows |> List.first([]) |> length()

    Map.new(words, fn word ->
      chars = String.graphemes(word)

      location =
        if height == 0 or width == 0 or chars == [] do
          nil
        else
          for(
            row <- 0..(height - 1),
            column <- 0..(width - 1),
            direction <- directions(),
            Enum.at(Enum.at(rows, row), column) == List.first(chars),
            matches?(rows, chars, row, column, direction),
            do: {row, column, direction}
          )
          |> List.first()
          |> location_for(chars)
        end

      {word, location}
    end)
  end

  defp directions do
    for row_step <- -1..1,
        column_step <- -1..1,
        row_step != 0 or column_step != 0,
        do: {row_step, column_step}
  end

  defp matches?(_rows, [], _row, _column, _direction), do: true

  defp matches?(rows, [char | rest], row, column, {row_step, column_step}) do
    row_chars = Enum.at(rows, row, [])

    row >= 0 and row < length(rows) and column >= 0 and column < length(row_chars) and
      Enum.at(row_chars, column) == char and
      matches?(rows, rest, row + row_step, column + column_step, {row_step, column_step})
  end

  defp location_for(nil, _chars), do: nil

  defp location_for({row, column, {row_step, column_step}}, chars) do
    distance = length(chars) - 1

    %Location{
      from: %{row: row + 1, column: column + 1},
      to: %{row: row + row_step * distance + 1, column: column + column_step * distance + 1}
    }
  end
end
