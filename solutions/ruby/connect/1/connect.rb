class Board
  NEIGHBORS = [[-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0]]

  def initialize(board)
    @board = board.map { |r| r.split(' ') }
  end

  def winner
    rows = @board.length
    cols = @board[0].length

    (0...rows).each do |r|
      return 'X' if dfs(r, 0, 'X', rows, cols, {})
    end
    (0...cols).each do |c|
      return 'O' if dfs(0, c, 'O', rows, cols, {})
    end
    ''
  end

  private

  def dfs(r, c, player, rows, cols, visited)
    return false if r < 0 || r >= rows || c < 0 || c >= cols
    return false if visited[[r, c]]
    return false if @board[r][c] != player

    if player == 'X'
      return true if c == cols - 1
    else
      return true if r == rows - 1
    end

    visited[[r, c]] = true

    NEIGHBORS.any? { |dr, dc| dfs(r + dr, c + dc, player, rows, cols, visited) }
  end
end
