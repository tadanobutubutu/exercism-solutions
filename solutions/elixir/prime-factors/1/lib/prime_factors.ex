defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factorize(number, 2, [])
    |> Enum.reverse()
  end

  defp factorize(1, _divisor, factors), do: factors

  defp factorize(number, divisor, factors) when divisor * divisor > number do
    [number | factors]
  end

  defp factorize(number, divisor, factors) do
    if rem(number, divisor) == 0 do
      factorize(div(number, divisor), divisor, [divisor | factors])
    else
      next_divisor = if divisor == 2, do: 3, else: divisor + 2
      factorize(number, next_divisor, factors)
    end
  end
end
