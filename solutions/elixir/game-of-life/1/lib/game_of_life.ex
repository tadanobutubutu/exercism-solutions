defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick(matrix) do
    height = length(matrix)

    if height == 0 do
      []
    else
      width = matrix |> hd() |> length()

      if width == 0 do
        List.duplicate([], height)
      else

        for row <- 0..(height - 1) do
          for column <- 0..(width - 1) do
            neighbors =
              for neighbor_row <- max(0, row - 1)..min(height - 1, row + 1),
                  neighbor_column <- max(0, column - 1)..min(width - 1, column + 1),
                  {neighbor_row, neighbor_column} != {row, column},
                  do: matrix |> Enum.at(neighbor_row) |> Enum.at(neighbor_column)

            live_neighbors = Enum.sum(neighbors)
            cell = matrix |> Enum.at(row) |> Enum.at(column)

            cond do
              cell == 1 and live_neighbors in [2, 3] -> 1
              cell == 0 and live_neighbors == 3 -> 1
              true -> 0
            end
          end
        end
      end
    end
  end
end
