defmodule ResistorColorTrio do
  @color_codes %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [first, second, third | _] = colors
    value = (Map.fetch!(@color_codes, first) * 10 + Map.fetch!(@color_codes, second)) * Integer.pow(10, Map.fetch!(@color_codes, third))

    cond do
      value == 0 -> {0, :ohms}
      rem(value, 1_000_000_000) == 0 -> {div(value, 1_000_000_000), :gigaohms}
      rem(value, 1_000_000) == 0 -> {div(value, 1_000_000), :megaohms}
      rem(value, 1_000) == 0 -> {div(value, 1_000), :kiloohms}
      true -> {value, :ohms}
    end
  end
end
