defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    if limit <= 1 do
      0
    else
      1..(limit - 1)
      |> Enum.filter(fn number ->
        Enum.any?(factors, fn factor -> factor > 0 and rem(number, factor) == 0 end)
      end)
      |> Enum.sum()
    end
  end
end
