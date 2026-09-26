defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    if max_factor < min_factor do
      raise ArgumentError, "maximum factor must be greater than or equal to minimum factor"
    end

    Enum.reduce(min_factor..max_factor, %{}, fn left, products ->
      Enum.reduce(left..max_factor, products, fn right, products ->
        product = left * right

        if palindrome?(product) do
          Map.update(products, product, [[left, right]], &[[left, right] | &1])
        else
          products
        end
      end)
    end)
  end

  defp palindrome?(number) when number > 0 and rem(number, 10) == 0, do: false
  defp palindrome?(number), do: reverse_half(number, 0)

  defp reverse_half(number, reversed) when number > reversed,
    do: reverse_half(div(number, 10), reversed * 10 + rem(number, 10))

  defp reverse_half(number, reversed), do: number == reversed or number == div(reversed, 10)
end
