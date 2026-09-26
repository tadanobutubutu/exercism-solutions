defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  """
  @spec result_for([String.t()]) :: :none | :X | :O
  def result_for(board) do
    rows = Enum.map(board, &(String.replace(&1, " ", "") |> String.graphemes()))

    cond do
      connected?(rows, :X) -> :X
      connected?(rows, :O) -> :O
      true -> :none
    end
  end

  defp connected?(rows, mark) do
    height = length(rows)
    width = rows |> List.first([]) |> length()

    if height == 0 or width == 0 do
      false
    else
      connected_on_dimensions?(rows, mark, height, width)
    end
  end

  defp connected_on_dimensions?(rows, mark, height, width) do
    starts =
      if mark == :X do
        for row <- 0..(height - 1), Enum.at(Enum.at(rows, row, []), 0) == "X", do: {row, 0}
      else
        for column <- 0..(width - 1),
            Enum.at(Enum.at(rows, 0, []), column) == "O",
            do: {0, column}
      end

    target? = fn {row, column} ->
      if mark == :X, do: column == width - 1, else: row == height - 1
    end

    visit(starts, rows, mark, target?, MapSet.new())
  end

  defp visit([], _rows, _mark, _target?, _visited), do: false

  defp visit([position | rest], rows, mark, target?, visited) do
    {row, column} = position

    cond do
      MapSet.member?(visited, position) ->
        visit(rest, rows, mark, target?, visited)

      Enum.at(Enum.at(rows, row, []), column) != Atom.to_string(mark) ->
        visit(rest, rows, mark, target?, MapSet.put(visited, position))

      target?.(position) ->
        true

      true ->
        neighbors =
          [
            {row, column - 1},
            {row, column + 1},
            {row - 1, column},
            {row - 1, column + 1},
            {row + 1, column},
            {row + 1, column - 1}
          ]
          |> Enum.filter(fn {next_row, next_column} ->
            next_row >= 0 and next_row < length(rows) and next_column >= 0 and
              next_column < length(Enum.at(rows, next_row, [])) and
              Enum.at(Enum.at(rows, next_row), next_column) == Atom.to_string(mark)
          end)

        visit(neighbors ++ rest, rows, mark, target?, MapSet.put(visited, position))
    end
  end
end
