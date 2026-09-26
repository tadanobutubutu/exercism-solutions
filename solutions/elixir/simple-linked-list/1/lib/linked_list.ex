defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new, do: nil

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(nil), do: 0
  def count({_head, tail}), do: 1 + count(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(nil), do: true
  def empty?(_list), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(nil), do: {:error, :empty_list}
  def peek({head, _tail}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(nil), do: {:error, :empty_list}
  def tail({_head, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(nil), do: {:error, :empty_list}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    Enum.reduce(Enum.reverse(list), new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    to_list(list, [])
  end

  defp to_list(nil, result), do: Enum.reverse(result)
  defp to_list({head, tail}, result), do: to_list(tail, [head | result])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list |> to_list() |> Enum.reverse() |> from_list()
  end
end
