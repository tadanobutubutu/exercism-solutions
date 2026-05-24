class Grid
  def self.saddle_points(matrix)
    return [] if matrix.empty? || matrix[0].empty?
    rows = matrix.map(&:max)
    cols = matrix.transpose.map(&:min)
    result = []
    matrix.each_with_index do |row, i|
      row.each_with_index do |val, j|
        if val == rows[i] && val == cols[j]
          result << { "row" => i + 1, "column" => j + 1 }
        end
      end
    end
    result
  end
end
