defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_loaf, character), do: {nil, %{character | health: character.health + 5}}
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: strength}, character) do
      {%EmptyBottle{}, %{character | mana: character.mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_poison, character), do: {%EmptyBottle{}, %{character | health: 0}}
  end
end
