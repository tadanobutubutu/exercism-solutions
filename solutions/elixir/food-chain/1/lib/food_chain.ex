defmodule FoodChain do
  @animals ~w(fly spider bird cat dog goat cow horse)
  @exclamations %{
    "spider" => "It wriggled and jiggled and tickled inside her.",
    "bird" => "How absurd to swallow a bird!",
    "cat" => "Imagine that, to swallow a cat!",
    "dog" => "What a hog, to swallow a dog!",
    "goat" => "Just opened her throat and swallowed a goat!",
    "cow" => "I don't know how she swallowed a cow!",
    "horse" => "She's dead, of course!"
  }

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.map(&verse/1)
    |> Enum.join("\n\n")
    |> Kernel.<>("\n")
  end

  defp verse(8), do: "I know an old lady who swallowed a horse.\n#{@exclamations["horse"]}"

  defp verse(number) do
    animal = Enum.at(@animals, number - 1)
    opening = "I know an old lady who swallowed a #{animal}."
    exclamation = Map.get(@exclamations, animal)
    chain = if number == 1, do: [], else: catch_chain(number - 1)
    ending = "I don't know why she swallowed the fly. Perhaps she'll die."

    [opening, exclamation | chain]
    |> Enum.reject(&is_nil/1)
    |> Kernel.++([ending])
    |> Enum.join("\n")
  end

  defp catch_chain(last_index) do
    last_index..1//-1
    |> Enum.map(fn index ->
      prey = Enum.at(@animals, index - 1)
      predator = Enum.at(@animals, index)

      suffix = if prey == "spider", do: " that wriggled and jiggled and tickled inside her", else: ""
      "She swallowed the #{predator} to catch the #{prey}#{suffix}."
    end)
  end
end
