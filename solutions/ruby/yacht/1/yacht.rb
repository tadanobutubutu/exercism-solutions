class Yacht
  def initialize(dice, category)
    @dice = dice
    @category = category
  end

  def score
    counts = @dice.each_with_object(Hash.new(0)) { |die, hash| hash[die] += 1 }
    
    case @category
    when 'ones'
      (@dice.count(1)) * 1
    when 'twos'
      (@dice.count(2)) * 2
    when 'threes'
      (@dice.count(3)) * 3
    when 'fours'
      (@dice.count(4)) * 4
    when 'fives'
      (@dice.count(5)) * 5
    when 'sixes'
      (@dice.count(6)) * 6
    when 'full house'
      if counts.values.sort == [2, 3]
        @dice.sum
      else
        0
      end
    when 'four of a kind'
      kind = counts.find { |_, v| v >= 4 }
      kind ? kind[0] * 4 : 0
    when 'little straight'
      @dice.sort == [1, 2, 3, 4, 5] ? 30 : 0
    when 'big straight'
      @dice.sort == [2, 3, 4, 5, 6] ? 30 : 0
    when 'choice'
      @dice.sum
    when 'yacht'
      counts.values.include?(5) ? 50 : 0
    else
      0
    end
  end
end
