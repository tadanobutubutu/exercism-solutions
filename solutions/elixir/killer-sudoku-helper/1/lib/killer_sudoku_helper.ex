defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage) do
    1..9
    |> Enum.reject(&(&1 in cage.exclude))
    |> choose(cage.size, cage.sum)
  end

  defp choose(_digits, 0, 0), do: [[]]
  defp choose(_digits, 0, _sum), do: []
  defp choose([], _size, _sum), do: []

  defp choose([digit | rest], size, sum) when size > 0 and sum >= 0 do
    with_digit =
      choose(rest, size - 1, sum - digit)
      |> Enum.map(&[digit | &1])

    with_digit ++ choose(rest, size, sum)
  end

  defp choose(_digits, _size, _sum), do: []
end
