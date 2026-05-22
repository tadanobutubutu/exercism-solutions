class Matrix
  def initialize(matrix_str)
    @rows = matrix_str.split("\n").map { |row| row.split.map(&:to_i) }
    @columns = @rows.transpose
  end

  def row(i)
    @rows[i - 1]
  end

  def column(i)
    @columns[i - 1]
  end
end
