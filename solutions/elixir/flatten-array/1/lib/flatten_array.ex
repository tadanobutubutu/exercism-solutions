defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> flatten_reversed([])
    |> Enum.reverse()
  end

  defp flatten_reversed([], flattened), do: flattened

  defp flatten_reversed([nil | tail], flattened) do
    flatten_reversed(tail, flattened)
  end

  defp flatten_reversed([head | tail], flattened) when is_list(head) do
    flatten_reversed(tail, flatten_reversed(head, flattened))
  end

  defp flatten_reversed([head | tail], flattened) do
    flatten_reversed(tail, [head | flattened])
  end
end
