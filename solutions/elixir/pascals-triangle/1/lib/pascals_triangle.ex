defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    if num <= 0 do
      []
    else
      Enum.reduce(1..num, {[], []}, fn _, {rows, previous} ->
        current =
          case previous do
            [] -> [1]
            _ -> [1 | Enum.chunk_every(previous, 2, 1, :discard) |> Enum.map(&Enum.sum/1)] ++ [1]
          end

        {rows ++ [current], current}
      end)
      |> elem(0)
    end
  end
end
