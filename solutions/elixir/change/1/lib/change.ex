defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    cond do
      target < 0 ->
        {:error, "cannot change"}

      target == 0 ->
        {:ok, []}

      true ->
        coins = coins |> Enum.filter(&(&1 > 0)) |> Enum.uniq()

        best =
          Enum.reduce(1..target, %{0 => []}, fn amount, solutions ->
            candidates =
              for coin <- coins,
                  coin <= amount,
                  Map.has_key?(solutions, amount - coin),
                  do: Map.fetch!(solutions, amount - coin) ++ [coin]

            case candidates do
              [] -> solutions
              _ -> Map.put(solutions, amount, Enum.min_by(candidates, &length/1))
            end
          end)

        case Map.fetch(best, target) do
          {:ok, result} -> {:ok, Enum.sort(result)}
          :error -> {:error, "cannot change"}
        end
    end
  end
end
