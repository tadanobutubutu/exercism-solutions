class Triangle
  def initialize(rows)
    @rows = rows
  end

  def rows
    result = []
    @rows.times do |i|
      row = [1]
      if i > 0
        prev = result.last
        (1...i).each { |j| row << prev[j - 1] + prev[j] }
        row << 1
      end
      result << row
    end
    result
  end
end
