defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    if limit < 2 do
      []
    else
      for candidate <- 2..limit,
          prime?(candidate),
          do: candidate
    end
  end

  defp prime?(2), do: true

  defp prime?(candidate) do
    limit = trunc(:math.sqrt(candidate))

    limit < 2 or
      not Enum.any?(2..limit, fn divisor -> rem(candidate, divisor) == 0 end)
  end
end
