class Game
  class BowlingError < StandardError; end

  def initialize
    @frames = Array.new(10) { [] }
    @current = 0
  end

  def roll(pins)
    raise BowlingError if pins < 0 || pins > 10
    raise BowlingError if done?

    if @current < 9
      frame = @frames[@current]
      if frame.empty?
        if pins == 10
          @frames[@current] = [10]
          @current += 1
        else
          frame << pins
        end
      else
        raise BowlingError if frame[0] + pins > 10
        frame << pins
        @current += 1
      end
    else
      fill = @frames[9]
      if fill.length == 1 && fill[0] == 10
        fill << pins
      elsif fill.length == 1
        raise BowlingError if fill[0] + pins > 10
        fill << pins
      elsif fill.length == 2 && fill[0] == 10
        if fill[1] != 10
          raise BowlingError if pins == 10
          raise BowlingError if fill[1] + pins > 10
        end
        fill << pins
      else
        fill << pins
      end
      advance_tenth if tenth_done?
    end
  end

  def score
    raise BowlingError if @frames.flatten.empty?
    raise BowlingError unless all_done?

    total = 0
    @frames.each_with_index do |frame, i|
      if i < 9
        if frame == [10]
          nxt = next_two(i)
          total += 10 + nxt.sum
        elsif frame.sum == 10
          nxt = next_one(i)
          total += 10 + nxt
        else
          total += frame.sum
        end
      else
        total += frame.sum
      end
    end
    total
  end

  private

  def done?
    @current > 9 && tenth_done?
  end

  def all_done?
    @current > 9 && tenth_done?
  end

  def tenth_done?
    f = @frames[9]
    return false if f.empty?
    if f[0] == 10
      f.length == 3
    elsif f.length >= 2
      f.length == 3 || f[0] + f[1] < 10
    else
      false
    end
  end

  def advance_tenth
    @current = 10 if tenth_done?
  end

  def next_two(idx)
    rolls = []
    @frames[(idx + 1)..].each do |frame|
      frame.each do |p|
        rolls << p
        return rolls if rolls.length == 2
      end
    end
    rolls
  end

  def next_one(idx)
    @frames[(idx + 1)..].flatten.first || 0
  end
end
