defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(pos_integer()) :: pos_integer()
  def nth(count) when is_integer(count) and count > 0 do
    if count == 1 do
      2
    else
      find_nth_prime(3, 1, count)
    end
  end

  defp find_nth_prime(candidate, found, target) do
    if prime?(candidate) do
      if found + 1 == target do
        candidate
      else
        find_nth_prime(candidate + 2, found + 1, target)
      end
    else
      find_nth_prime(candidate + 2, found, target)
    end
  end

  defp prime?(number), do: prime?(number, 3)
  defp prime?(number, divisor) when divisor * divisor > number, do: true
  defp prime?(number, divisor) when rem(number, divisor) == 0, do: false
  defp prime?(number, divisor), do: prime?(number, divisor + 2)
end
