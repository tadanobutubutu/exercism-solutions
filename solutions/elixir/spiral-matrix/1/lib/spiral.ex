defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension) do
    if dimension <= 0 do
      []
    else
      blank = List.duplicate(List.duplicate(0, dimension), dimension)
      fill(blank, dimension, 0, 0, 0, 1)
    end
  end

  defp fill(matrix, dimension, _row, _column, _direction, value) when value > dimension * dimension,
    do: matrix

  defp fill(matrix, dimension, row, column, direction, value) do
    matrix = put_cell(matrix, row, column, value)
    {delta_row, delta_column} = Enum.at([{0, 1}, {1, 0}, {0, -1}, {-1, 0}], direction)
    next_row = row + delta_row
    next_column = column + delta_column

    {next_row, next_column, next_direction} =
      if valid_empty?(matrix, dimension, next_row, next_column) do
        {next_row, next_column, direction}
      else
        next_direction = rem(direction + 1, 4)
        {delta_row, delta_column} = Enum.at([{0, 1}, {1, 0}, {0, -1}, {-1, 0}], next_direction)
        {row + delta_row, column + delta_column, next_direction}
      end

    fill(matrix, dimension, next_row, next_column, next_direction, value + 1)
  end

  defp valid_empty?(matrix, dimension, row, column) do
    row >= 0 and row < dimension and column >= 0 and column < dimension and
      matrix |> Enum.at(row) |> Enum.at(column) == 0
  end

  defp put_cell(matrix, row, column, value) do
    updated_row = matrix |> Enum.at(row) |> List.replace_at(column, value)
    List.replace_at(matrix, row, updated_row)
  end
end
