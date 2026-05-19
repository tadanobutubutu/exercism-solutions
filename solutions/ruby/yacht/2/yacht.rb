class Yacht
  def initialize(dice, category)
    @dice = dice
    @category = category
  end
  
  def score
    if @category == 'yacht'
      @dice.uniq.length == 1 ? 50 : 0
    elsif @category == 'ones'
      @dice.count(1) * 1
    elsif @category == 'twos'
      @dice.count(2) * 2
    elsif @category == 'threes'
      @dice.count(3) * 3
    elsif @category == 'fours'
      @dice.count(4) * 4
    elsif @category == 'fives'
      @dice.count(5) * 5
    elsif @category == 'sixes'
      @dice.count(6) * 6
    elsif @category == 'four of a kind'
      groups = @dice.group_by(&:itself)
      target_value = groups.find { |_, v| v.length >= 4 }&.first
      target_value ? target_value * 4 : 0
    elsif @category == 'full house'
      return 0 unless @dice.uniq.length == 2
      counts = @dice.group_by(&:itself).values.map(&:count).sort
      counts == [2, 3] ? @dice.sum : 0
    elsif @category == 'little straight'
      @dice.sort == [1, 2, 3, 4, 5] ? 30 : 0
    elsif @category == 'big straight'
      @dice.sort == [2, 3, 4, 5, 6] ? 30 : 0
    elsif @category == 'choice'
      @dice.sum
    end
  end
end
