class Queens
  def initialize(white: [0, 0], black: [0, 0])
    @white = white
    @black = black
    
    raise ArgumentError unless valid?(@white) && valid?(@black)
  end

  def valid?(pos)
    pos.all? { |coord| coord >= 0 && coord < 8 }
  end

  def attack?
    @white[0] == @black[0] || # Same row
      @white[1] == @black[1] || # Same column
      (@white[0] - @black[0]).abs == (@white[1] - @black[1]).abs # Same diagonal
  end
end
