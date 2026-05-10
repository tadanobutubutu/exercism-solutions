class SpiralMatrix
  def initialize(size)
    @size = size
  end

  def matrix
    return [] if @size == 0
    
    matrix = Array.new(@size) { Array.new(@size) }
    
    row, col = 0, 0
    dr, dc = 0, 1 # Initial direction: right
    
    (1..(@size * @size)).each do |i|
      matrix[row][col] = i
      
      # Check next position
      next_row, next_col = row + dr, col + dc
      
      if next_row < 0 || next_row >= @size || 
         next_col < 0 || next_col >= @size || 
         !matrix[next_row][next_col].nil?
        
        # Change direction: right -> down -> left -> up -> right ...
        dr, dc = dc, -dr
        next_row, next_col = row + dr, col + dc
      end
      
      row, col = next_row, next_col
    end
    
    matrix
  end
end
