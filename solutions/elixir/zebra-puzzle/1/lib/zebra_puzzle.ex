defmodule ZebraPuzzle do
  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water, do: solution().water_drinker

  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra, do: solution().zebra_owner

  defp solution do
    colors = positions([:red, :green, :ivory, :yellow, :blue])
    nationalities = positions([:englishman, :spaniard, :ukrainian, :japanese, :norwegian])
    drinks = positions([:coffee, :tea, :milk, :orange_juice, :water])
    hobbies = positions([:dancing, :painter, :football, :reading, :chess])
    pets = positions([:dog, :snails, :fox, :horse, :zebra])

    Enum.find_value(colors, fn color ->
      if color.green == color.ivory + 1 do
        Enum.find_value(nationalities, fn nationality ->
          if nationality.norwegian == 1 and nationality.englishman == color.red and
               abs(nationality.norwegian - color.blue) == 1 do
            Enum.find_value(drinks, fn drink ->
              if drink.coffee == color.green and drink.milk == 3 and
                   drink.tea == nationality.ukrainian do
                Enum.find_value(hobbies, fn hobby ->
                  if hobby.painter == color.yellow and hobby.football == drink.orange_juice and
                       hobby.chess == nationality.japanese do
                    Enum.find_value(pets, fn pet ->
                      if pet.dog == nationality.spaniard and pet.snails == hobby.dancing and
                           adjacent?(hobby.painter, pet.horse) and
                           adjacent?(hobby.reading, pet.fox) do
                        %{
                          water_drinker: owner_at(nationality, drink.water),
                          zebra_owner: owner_at(nationality, pet.zebra)
                        }
                      end
                    end)
                  end
                end)
              end
            end)
          end
        end)
      end
    end)
  end

  defp positions(categories) do
    permutations([1, 2, 3, 4, 5])
    |> Enum.map(&Map.new(Enum.zip(categories, &1)))
  end

  defp permutations([]), do: [[]]

  defp permutations(values) do
    for value <- values,
        rest <- permutations(List.delete(values, value)),
        do: [value | rest]
  end

  defp adjacent?(left, right), do: abs(left - right) == 1

  defp owner_at(positions, location) do
    Enum.find_value(positions, fn {owner, position} -> if position == location, do: owner end)
  end
end
