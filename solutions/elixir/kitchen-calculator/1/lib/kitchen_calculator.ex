defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    case volume_pair do
      {:cup, volume} -> {:milliliter, volume * 240}
      {:fluid_ounce, volume} -> {:milliliter, volume * 30}
      {:teaspoon, volume} -> {:milliliter, volume * 5}
      {:tablespoon, volume} -> {:milliliter, volume * 15}
      {:milliliter, volume} -> {:milliliter, volume}
    end
  end

  def from_milliliter(volume_pair, unit) do
    milliliters = get_volume(volume_pair)

    case unit do
      :cup -> {:cup, milliliters / 240}
      :fluid_ounce -> {:fluid_ounce, milliliters / 30}
      :teaspoon -> {:teaspoon, milliliters / 5}
      :tablespoon -> {:tablespoon, milliliters / 15}
      :milliliter -> {:milliliter, milliliters}
    end
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
