defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    count_bits(abs(number), 0)
  end

  defp count_bits(0, count), do: count

  defp count_bits(number, count) do
    count_bits(div(number, 2), count + rem(number, 2))
  end
end
