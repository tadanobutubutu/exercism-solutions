defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    chars = String.graphemes(word)
    first_two = Enum.take(chars, 2) |> Enum.join()

    cond do
      hd(chars) in ["a", "e", "i", "o", "u"] or first_two in ["xr", "yt"] ->
        word <> "ay"

      true ->
        cut = consonant_cluster_length(chars)
        {onset, rest} = Enum.split(chars, cut)
        Enum.join(rest) <> Enum.join(onset) <> "ay"
    end
  end

  defp consonant_cluster_length(chars) do
    first_vowel = Enum.find_index(chars, &(&1 in ["a", "e", "i", "o", "u"]))
    qu_end =
      chars
      |> Enum.with_index()
      |> Enum.find_value(fn {char, index} ->
        if char == "q" and Enum.at(chars, index + 1) == "u" and
             (first_vowel == nil or index < first_vowel) do
          index + 2
        end
      end)

    y_index = Enum.find_index(chars, &(&1 == "y"))

    cond do
      qu_end != nil -> qu_end
      y_index != nil and y_index > 0 and (first_vowel == nil or y_index < first_vowel) -> y_index
      first_vowel != nil -> first_vowel
      true -> length(chars)
    end
  end
end
