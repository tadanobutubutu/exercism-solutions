defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    frequencies = Enum.frequencies(dice)

    case category do
      :ones -> count(dice, 1)
      :twos -> count(dice, 2)
      :threes -> count(dice, 3)
      :fours -> count(dice, 4)
      :fives -> count(dice, 5)
      :sixes -> count(dice, 6)
      :choice -> Enum.sum(dice)
      :yacht -> if map_size(frequencies) == 1, do: 50, else: 0
      :full_house -> if Enum.sort(Map.values(frequencies)) == [2, 3], do: Enum.sum(dice), else: 0
      :four_of_a_kind ->
        case Enum.find(frequencies, fn {_face, amount} -> amount >= 4 end) do
          {face, _amount} -> 4 * face
          nil -> 0
        end

      :little_straight -> if Enum.sort(dice) == [1, 2, 3, 4, 5], do: 30, else: 0
      :big_straight -> if Enum.sort(dice) == [2, 3, 4, 5, 6], do: 30, else: 0
    end
  end

  defp count(dice, face), do: Enum.count(dice, &(&1 == face)) * face
end
