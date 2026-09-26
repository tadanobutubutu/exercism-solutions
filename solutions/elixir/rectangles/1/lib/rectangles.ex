defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    rows =
      if input == "" do
        []
      else
        input
        |> String.trim_trailing("\n")
        |> String.split("\n")
        |> Enum.map(&String.graphemes/1)
      end

    height = length(rows)
    width = rows |> Enum.map(&length/1) |> Enum.max(fn -> 0 end)

    if height < 2 or width < 2 do
      0
    else
      grid = Enum.map(rows, &(&1 ++ List.duplicate(" ", width - length(&1))))

      rectangles =
        for top <- 0..(height - 2),
            left <- 0..(width - 2),
            cell(grid, top, left) == "+",
            bottom <- (top + 1)..(height - 1),
            right <- (left + 1)..(width - 1),
            cell(grid, top, right) == "+",
            cell(grid, bottom, left) == "+",
            cell(grid, bottom, right) == "+",
            horizontal?(grid, top, left, right),
            horizontal?(grid, bottom, left, right),
            vertical?(grid, left, top, bottom),
            vertical?(grid, right, top, bottom),
            do: 1

      length(rectangles)
    end
  end

  defp cell(grid, row, column), do: grid |> Enum.at(row) |> Enum.at(column)

  defp horizontal?(grid, row, left, right) do
    Enum.all?(left..right, &(cell(grid, row, &1) in ["+", "-"]))
  end

  defp vertical?(grid, column, top, bottom) do
    Enum.all?(top..bottom, &(cell(grid, &1, column) in ["+", "|"]))
  end
end
