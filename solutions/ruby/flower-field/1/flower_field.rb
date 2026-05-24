class FlowerField
  NEIGHBORS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

  def self.annotate(field)
    return field if field.empty? || field[0].empty?
    field.each_with_index.map do |row, i|
      row.chars.each_with_index.map do |cell, j|
        if cell == '*'
          '*'
        else
          count = NEIGHBORS.count { |di, dj|
            ni = i + di
            nj = j + dj
            ni >= 0 && ni < field.length && nj >= 0 && nj < row.length && field[ni][nj] == '*'
          }
          count == 0 ? ' ' : count.to_s
        end
      end.join
    end
  end
end
