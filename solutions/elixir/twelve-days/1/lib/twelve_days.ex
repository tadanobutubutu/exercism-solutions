defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    ordinals = ~w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
    gifts = [
      "a Partridge in a Pear Tree",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying",
      "seven Swans-a-Swimming",
      "eight Maids-a-Milking",
      "nine Ladies Dancing",
      "ten Lords-a-Leaping",
      "eleven Pipers Piping",
      "twelve Drummers Drumming"
    ]

    gift_list = gifts |> Enum.take(number) |> Enum.reverse()
    gift_text = join_gifts(gift_list)
    "On the #{Enum.at(ordinals, number - 1)} day of Christmas my true love gave to me: #{gift_text}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp join_gifts([gift]), do: gift
  defp join_gifts([last, "a Partridge in a Pear Tree"]), do: last <> ", and a Partridge in a Pear Tree"

  defp join_gifts(gifts) do
    [last | rest] = Enum.reverse(gifts)
    Enum.join(Enum.reverse(rest), ", ") <> ", and " <> last
  end
end
