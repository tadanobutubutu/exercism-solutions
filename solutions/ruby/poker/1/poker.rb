class Poker
  def initialize(hands)
    @hands = hands
  end

  def best_hand
    ranks = @hands.map { |hand| hand_rank(hand) }
    max_rank = ranks.max
    # Find all hands that have the max_rank
    @hands.select.with_index { |_, i| ranks[i] == max_rank }
  end

  private

  def hand_rank(hand)
    # The hand is an array of strings like ["4S", "5S", "7H", "8D", "JC"]
    ranks = hand.map { |card| rank_value(card[0...-1]) }.sort.reverse
    suits = hand.map { |card| card[-1] }
    
    # Counts for groups (e.g. four of a kind, full house, pairs)
    counts = ranks.group_by { |r| r }.map { |r, list| [r, list.size] }.sort_by { |r, size| [-size, -r] }
    
    is_flush = suits.uniq.size == 1
    
    # Check for straight
    is_straight = false
    # Check for regular straight
    sorted_ranks = ranks.sort
    if sorted_ranks == (sorted_ranks.min..(sorted_ranks.min + 4)).to_a
      is_straight = true
    # Check for A-5 straight (14, 5, 4, 3, 2)
    elsif sorted_ranks == [2, 3, 4, 5, 14]
      is_straight = true
      ranks = [5, 4, 3, 2, 1]
    end
    
    # Rank comparison
    if is_flush && is_straight
      [8, ranks]
    elsif counts[0][1] == 4
      [7, counts[0][0], counts[1][0]]
    elsif counts[0][1] == 3 && counts[1][1] == 2
      [6, counts[0][0], counts[1][0]]
    elsif is_flush
      [5, ranks]
    elsif is_straight
      [4, ranks]
    elsif counts[0][1] == 3
      [3, counts[0][0], ranks.reject { |r| r == counts[0][0] }]
    elsif counts[0][1] == 2 && counts[1][1] == 2
      [2, counts[0][0], counts[1][0], counts[2][0]]
    elsif counts[0][1] == 2
      [1, counts[0][0], ranks.reject { |r| r == counts[0][0] }]
    else
      [0, ranks]
    end
  end

  def rank_value(r)
    case r
    when 'J' then 11
    when 'Q' then 12
    when 'K' then 13
    when 'A' then 14
    when '10' then 10
    else r.to_i
    end
  end
end
