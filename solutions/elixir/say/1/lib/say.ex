defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) do
    cond do
      number < 0 or number > 999_999_999_999 ->
        {:error, "number is out of range"}

      number == 0 ->
        {:ok, "zero"}

      true ->
        {:ok, number_to_words(number)}
    end
  end

  @small_numbers ~w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  @tens %{20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"}
  @scales [{1_000_000_000, "billion"}, {1_000_000, "million"}, {1_000, "thousand"}]

  defp number_to_words(number) when number < 1_000, do: under_one_thousand(number)

  defp number_to_words(number) do
    {groups, remainder} =
      Enum.reduce(@scales, {[], number}, fn {scale, label}, {words, remaining} ->
        quantity = div(remaining, scale)

        if quantity == 0 do
          {words, remaining}
        else
          {words ++ [under_one_thousand(quantity) <> " " <> label], rem(remaining, scale)}
        end
      end)

    if remainder == 0 do
      Enum.join(groups, " ")
    else
      Enum.join(groups ++ [under_one_thousand(remainder)], " ")
    end
  end

  defp under_one_thousand(number) when number < 20, do: Enum.at(@small_numbers, number)

  defp under_one_thousand(number) when number < 100 do
    ten = div(number, 10) * 10
    unit = rem(number, 10)
    if unit == 0, do: @tens[ten], else: @tens[ten] <> "-" <> Enum.at(@small_numbers, unit)
  end

  defp under_one_thousand(number) do
    hundreds = div(number, 100)
    remainder = rem(number, 100)
    prefix = Enum.at(@small_numbers, hundreds) <> " hundred"
    if remainder == 0, do: prefix, else: prefix <> " " <> under_one_thousand(remainder)
  end
end
