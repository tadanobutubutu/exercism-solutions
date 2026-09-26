defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    counts =
      1..5
      |> Enum.map(fn book -> Enum.count(basket, &(&1 == book)) end)
      |> List.to_tuple()

    {price, _memo} = cheapest(counts, %{})
    price
  end

  import Bitwise

  @discount_by_group_size %{1 => 0, 2 => 5, 3 => 10, 4 => 20, 5 => 25}

  defp cheapest(counts, memo) do
    case Map.fetch(memo, counts) do
      {:ok, price} ->
        {price, memo}

      :error ->
        if Enum.all?(Tuple.to_list(counts), &(&1 == 0)) do
          {0, Map.put(memo, counts, 0)}
        else
          {best, memo} =
            1..31
            |> Enum.reduce({:infinity, memo}, fn mask, {best, memo} ->
              indices = for index <- 0..4, band(mask, 1 <<< index) != 0, do: index

              if Enum.all?(indices, &(elem(counts, &1) > 0)) do
                remaining =
                  Enum.reduce(indices, counts, fn index, counts ->
                    put_elem(counts, index, elem(counts, index) - 1)
                  end)

                {rest_price, memo} = cheapest(remaining, memo)
                group_size = length(indices)

                group_price =
                  div(800 * group_size * (100 - @discount_by_group_size[group_size]), 100)

                candidate = rest_price + group_price
                {min(best, candidate), memo}
              else
                {best, memo}
              end
            end)

          {best, Map.put(memo, counts, best)}
        end
    end
  end
end
