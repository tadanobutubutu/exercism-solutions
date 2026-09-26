defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      contains?(b, a) -> :sublist
      contains?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp contains?(_list, []), do: true

  defp contains?(list, pattern) do
    pattern = List.to_tuple(pattern)
    size = tuple_size(pattern)
    failure = build_failure_table(pattern, size)
    scan(list, pattern, failure, 0)
  end

  defp build_failure_table(_pattern, size) when size <= 1, do: :array.new(size, default: 0)

  defp build_failure_table(pattern, size) do
    initial = :array.new(size, default: 0)

    Enum.reduce(1..(size - 1), initial, fn index, failure ->
      matched = prefix_length(pattern, index, :array.get(index - 1, failure), failure)
      matched = if elem(pattern, index) === elem(pattern, matched), do: matched + 1, else: matched
      :array.set(index, matched, failure)
    end)
  end

  defp prefix_length(pattern, index, matched, failure) do
    if matched > 0 and elem(pattern, index) !== elem(pattern, matched) do
      prefix_length(pattern, index, :array.get(matched - 1, failure), failure)
    else
      matched
    end
  end

  defp scan([], _pattern, _failure, _matched), do: false

  defp scan([item | rest], pattern, failure, matched) do
    matched = scan_prefix_length(pattern, item, matched, failure)

    if item === elem(pattern, matched) do
      if matched + 1 == tuple_size(pattern) do
        true
      else
        scan(rest, pattern, failure, matched + 1)
      end
    else
      scan(rest, pattern, failure, 0)
    end
  end

  defp scan_prefix_length(pattern, item, matched, failure) do
    if matched > 0 and item !== elem(pattern, matched) do
      scan_prefix_length(pattern, item, :array.get(matched - 1, failure), failure)
    else
      matched
    end
  end
end
