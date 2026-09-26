defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s+/, trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    matrix = rows(str)

    case matrix do
      [] -> []
      _ ->
        width = matrix |> Enum.map(&length/1) |> Enum.max()
        for column <- 0..(width - 1), do: Enum.map(matrix, &Enum.at(&1, column))
    end
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    matrix = rows(str)
    cols = columns(str)

    matrix
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {row, row_index} ->
      row_max = Enum.max(row)

      row
      |> Enum.with_index(1)
      |> Enum.filter(fn {value, column_index} ->
        value == row_max and Enum.min(Enum.at(cols, column_index - 1)) == value
      end)
      |> Enum.map(fn {_value, column_index} -> {row_index, column_index} end)
    end)
  end
end
