defmodule Camicia do
  @doc """
    Simulate a card game between two players.
    Each player has a deck of cards represented as a list of strings.
    Returns a tuple with the result of the game:
    - `{:finished, cards, tricks}` if the game finishes with a winner
    - `{:loop, cards, tricks}` if the game enters a loop
    `cards` is the number of cards played.
    `tricks` is the number of central piles collected.

    ## Examples

      iex> Camicia.simulate(["2"], ["3"])
      {:finished, 2, 1}

      iex> Camicia.simulate(["J", "2", "3"], ["4", "J", "5"])
      {:loop, 8, 3}
  """

  @spec simulate(list(String.t()), list(String.t())) ::
          {:finished | :loop, non_neg_integer(), non_neg_integer()}
  def simulate(player_a, player_b) do
    total_cards = length(player_a) + length(player_b)
    play(player_a, player_b, [], :a, nil, 0, 0, MapSet.new(), total_cards)
  end

  defp play(player_a, player_b, pile, turn, penalty, cards, tricks, seen, total_cards) do
    key = state_key(player_a, player_b, pile, turn, penalty)

    if MapSet.member?(seen, key) do
      {:loop, cards, tricks}
    else
      seen = MapSet.put(seen, key)
      deck = deck_for(turn, player_a, player_b)

      case deck do
        [] ->
          collect(player_a, player_b, pile, other(turn), cards, tricks, seen, total_cards)

        [card | remaining] ->
          {player_a, player_b} = put_deck(turn, remaining, player_a, player_b)
          pile = [card | pile]
          cards = cards + 1

          case {payment(card), penalty} do
            {rank, _pending} when is_integer(rank) ->
              play(
                player_a,
                player_b,
                pile,
                other(turn),
                {turn, rank},
                cards,
                tricks,
                seen,
                total_cards
              )

            {nil, {owner, 1}} ->
              collect(player_a, player_b, pile, owner, cards, tricks, seen, total_cards)

            {nil, {owner, remaining_penalty}} ->
              play(
                player_a,
                player_b,
                pile,
                turn,
                {owner, remaining_penalty - 1},
                cards,
                tricks,
                seen,
                total_cards
              )

            {nil, nil} ->
              play(
                player_a,
                player_b,
                pile,
                other(turn),
                nil,
                cards,
                tricks,
                seen,
                total_cards
              )
          end
      end
    end
  end

  defp collect(player_a, player_b, pile, winner, cards, tricks, seen, total_cards) do
    collected = Enum.reverse(pile)
    winner_deck = deck_for(winner, player_a, player_b) ++ collected
    {player_a, player_b} = put_deck(winner, winner_deck, player_a, player_b)
    tricks = tricks + 1

    if length(winner_deck) == total_cards do
      {:finished, cards, tricks}
    else
      play(player_a, player_b, [], winner, nil, cards, tricks, seen, total_cards)
    end
  end

  defp state_key(player_a, player_b, pile, turn, penalty) do
    {normalize(player_a), normalize(player_b), normalize(pile), turn, penalty}
  end

  defp normalize(cards), do: Enum.map(cards, &if(payment(&1), do: &1, else: :number))

  defp deck_for(:a, player_a, _player_b), do: player_a
  defp deck_for(:b, _player_a, player_b), do: player_b

  defp put_deck(:a, deck, _player_a, player_b), do: {deck, player_b}
  defp put_deck(:b, deck, player_a, _player_b), do: {player_a, deck}

  defp other(:a), do: :b
  defp other(:b), do: :a

  defp payment("J"), do: 1
  defp payment("Q"), do: 2
  defp payment("K"), do: 3
  defp payment("A"), do: 4
  defp payment(_card), do: nil
end
