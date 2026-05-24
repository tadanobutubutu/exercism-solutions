require 'set'

class TwoBucket
  attr_reader :moves, :goal_bucket, :other_bucket

  def initialize(size1, size2, goal, start)
    @size1 = size1
    @size2 = size2
    @goal = goal
    @start = start
    solve
  end

  private

  def solve
    start_state = @start == "one" ? [@size1, 0] : [0, @size2]
    visited = Set.new([start_state])
    queue = [[start_state, 1]]
    best = nil

    until queue.empty?
      (b1, b2), steps = queue.shift
      next if best && steps > best[:moves]

      result = check_goal(b1, b2, steps)
      if result
        if best.nil? || steps < best[:moves]
          best = result
        elsif steps == best[:moves]
          if @size1 >= @goal || @size2 >= @goal
            if result[:goal_bucket] == @start
              best = result
            end
          end
        end
        next
      end

      possible_moves(b1, b2).each do |state|
        next if visited.include?(state)
        visited.add(state)
        queue << [state, steps + 1]
      end
    end

    @moves = best[:moves]
    @goal_bucket = best[:goal_bucket]
    @other_bucket = best[:other_bucket]
  end

  def check_goal(b1, b2, steps)
    found = []
    found << { moves: steps, goal_bucket: "one", other_bucket: b2 } if b1 == @goal
    found << { moves: steps, goal_bucket: "two", other_bucket: b1 } if b2 == @goal
    return nil if found.empty?

    if @start == "one" && @size1 >= @goal
      found.find { |r| r[:goal_bucket] == "one" }
    elsif @start == "two" && @size2 >= @goal
      found.find { |r| r[:goal_bucket] == "two" }
    else
      found.first
    end
  end

  def possible_moves(b1, b2)
    moves = []
    moves << [@size1, b2] unless b1 == @size1
    moves << [b1, @size2] unless b2 == @size2
    moves << [0, b2] unless b1 == 0
    moves << [b1, 0] unless b2 == 0
    unless b1 == 0 || b2 == @size2
      pour = [b1, @size2 - b2].min
      moves << [b1 - pour, b2 + pour]
    end
    unless b2 == 0 || b1 == @size1
      pour = [b2, @size1 - b1].min
      moves << [b1 + pour, b2 - pour]
    end
    moves.uniq.reject { |state| invalid?(state) }
  end

  def invalid?(state)
    b1, b2 = state
    if @start == "one"
      b1 == 0 && b2 == @size2
    else
      b2 == 0 && b1 == @size1
    end
  end
end
