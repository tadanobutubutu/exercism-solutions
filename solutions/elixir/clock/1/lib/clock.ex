defmodule Clock do
  @type t() :: %__MODULE__{hour: integer, minute: integer}
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: t()
  def new(hour, minute) do
    total_minutes = Integer.mod(hour * 60 + minute, 24 * 60)
    %Clock{hour: div(total_minutes, 60), minute: rem(total_minutes, 60)}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(t(), integer) :: t()
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}) do
    String.pad_leading(Integer.to_string(hour), 2, "0") <>
      ":" <> String.pad_leading(Integer.to_string(minute), 2, "0")
  end
end
