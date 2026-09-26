defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    scores = Enum.map(hands, &score/1)
    best = Enum.max(scores)

    hands
    |> Enum.zip(scores)
    |> Enum.filter(fn {_hand, hand_score} -> hand_score == best end)
    |> Enum.map(&elem(&1, 0))
  end

  defp score(hand) do
    cards = Enum.map(hand, &parse_card/1)
    ranks = Enum.map(cards, &elem(&1, 0))
    suits = Enum.map(cards, &elem(&1, 1))

    groups =
      ranks
      |> Enum.frequencies()
      |> Enum.map(fn {rank, count} -> {count, rank} end)
      |> Enum.sort(:desc)

    flush? = Enum.uniq(suits) |> length() == 1
    straight = straight_high(ranks)

    cond do
      flush? and straight ->
        [8, straight]

      match?([{4, _}, {1, _}], groups) ->
        [7, elem(Enum.at(groups, 0), 1), elem(Enum.at(groups, 1), 1)]

      match?([{3, _}, {2, _}], groups) ->
        [6, elem(Enum.at(groups, 0), 1), elem(Enum.at(groups, 1), 1)]

      flush? ->
        [5 | Enum.sort(ranks, :desc)]

      straight ->
        [4, straight]

      match?([{3, _}, {1, _}, {1, _}], groups) ->
        [trip | rest] = groups
        [3, elem(trip, 1) | Enum.map(rest, &elem(&1, 1))]

      match?([{2, _}, {2, _}, {1, _}], groups) ->
        [high_pair, low_pair, kicker] = groups
        [2, elem(high_pair, 1), elem(low_pair, 1), elem(kicker, 1)]

      match?([{2, _}, {1, _}, {1, _}, {1, _}], groups) ->
        [pair | kickers] = groups
        [1, elem(pair, 1) | Enum.map(kickers, &elem(&1, 1))]

      true ->
        [0 | Enum.sort(ranks, :desc)]
    end
  end

  defp parse_card(card) do
    rank_text = String.slice(card, 0, String.length(card) - 1)
    suit = String.last(card)

    {Map.fetch!(
       %{
         "2" => 2,
         "3" => 3,
         "4" => 4,
         "5" => 5,
         "6" => 6,
         "7" => 7,
         "8" => 8,
         "9" => 9,
         "10" => 10,
         "J" => 11,
         "Q" => 12,
         "K" => 13,
         "A" => 14
       },
       rank_text
     ), suit}
  end

  defp straight_high(ranks) do
    sorted = Enum.sort(ranks)

    cond do
      length(Enum.uniq(sorted)) != 5 -> nil
      sorted == [2, 3, 4, 5, 14] -> 5
      List.last(sorted) - hd(sorted) == 4 -> List.last(sorted)
      true -> nil
    end
  end
end
