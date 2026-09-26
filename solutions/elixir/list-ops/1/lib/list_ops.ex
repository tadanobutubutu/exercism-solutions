defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: count_items(l, 0)

  defp count_items([], total), do: total
  defp count_items([_ | tail], total), do: count_items(tail, total + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse_into(l, [])

  defp reverse_into([], reversed), do: reversed
  defp reverse_into([head | tail], reversed), do: reverse_into(tail, [head | reversed])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> foldl([], fn item, acc -> [f.(item) | acc] end)
    |> reverse()
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> foldl([], fn item, acc -> if f.(item), do: [item | acc], else: acc end)
    |> reverse()
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc
  def foldl([head | tail], acc, f), do: foldl(tail, f.(head, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: foldl(reverse(l), acc, f)

  @spec append(list, list) :: list
  def append(a, b) do
    append_reversed(reverse(a), b)
  end

  defp append_reversed([], result), do: result
  defp append_reversed([head | tail], result), do: append_reversed(tail, [head | result])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: foldr(ll, [], &append/2)
end
