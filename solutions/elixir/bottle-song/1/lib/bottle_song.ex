defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    names = %{
      0 => "no",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten"
    }

    start_bottle
    |> Stream.iterate(&(&1 - 1))
    |> Enum.take_while(&(&1 > 0))
    |> Enum.take(take_down)
    |> Enum.map_join("\n\n", fn count ->
      current = names[count]
      following = names[count - 1]
      bottle = if count == 1, do: "bottle", else: "bottles"

      """
      #{String.capitalize(current)} green #{bottle} hanging on the wall,
      #{String.capitalize(current)} green #{bottle} hanging on the wall,
      And if one green bottle should accidentally fall,
      There'll be #{following} green #{if count == 2, do: "bottle", else: "bottles"} hanging on the wall.
      """
      |> String.trim_trailing()
    end)
  end
end
