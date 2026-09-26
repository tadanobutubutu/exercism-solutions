defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    already_had_card = MapSet.member?(collection, card)
    {already_had_card, MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    trade_is_possible = MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card)
    new_collection = collection |> MapSet.delete(your_card) |> MapSet.put(their_card)
    {trade_is_possible, new_collection}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards |> Enum.uniq() |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection
    |> MapSet.difference(their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) do
    case collections do
      [] -> []
      [first | rest] ->
        rest
        |> Enum.reduce(first, &MapSet.intersection/2)
        |> MapSet.to_list()
        |> Enum.sort()
    end
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    collections
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny, regular} =
      Enum.split_with(collection, &String.starts_with?(&1, "Shiny"))

    {Enum.sort(shiny), Enum.sort(regular)}
  end
end
