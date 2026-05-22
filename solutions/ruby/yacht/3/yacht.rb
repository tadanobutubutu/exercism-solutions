class Yacht
  def initialize(dice, category)
    @dice = dice
    @category = category
  end

  def score
    counts = @dice.each_with_object(Hash.new(0)) { |d, h| h[d] += 1 }
    case @category
    when "yacht"
      counts.length == 1 ? 50 : 0
    when "ones"
      @dice.count(1) * 1
    when "twos"
      @dice.count(2) * 2
    when "threes"
      @dice.count(3) * 3
    when "fours"
      @dice.count(4) * 4
    when "fives"
      @dice.count(5) * 5
    when "sixes"
      @dice.count(6) * 6
    when "full house"
      counts.values.include?(3) && counts.values.include?(2) ? @dice.sum : 0
    when "four of a kind"
      counts.each { |d, c| return d * 4 if c >= 4 }
      0
    when "little straight"
      @dice.sort == [1, 2, 3, 4, 5] ? 30 : 0
    when "big straight"
      @dice.sort == [2, 3, 4, 5, 6] ? 30 : 0
    when "choice"
      @dice.sum
    else
      0
    end
  end
end