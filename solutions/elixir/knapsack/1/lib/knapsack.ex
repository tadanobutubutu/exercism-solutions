defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(_items, maximum_weight) when maximum_weight <= 0, do: 0

  def maximum_value(items, maximum_weight) do
    values = List.duplicate(0, maximum_weight + 1)

    values =
      Enum.reduce(items, values, fn %{value: value, weight: weight}, previous_values ->
        previous_values = List.to_tuple(previous_values)

        for capacity <- 0..maximum_weight do
          without_item = elem(previous_values, capacity)

          if weight <= capacity do
            max(without_item, elem(previous_values, capacity - weight) + value)
          else
            without_item
          end
        end
      end)

    List.last(values)
  end
end
