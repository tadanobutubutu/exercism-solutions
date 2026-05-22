class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @size = size
    @buffer = Array.new(size)
    @head = 0
    @tail = 0
    @count = 0
  end

  def read
    raise BufferEmptyException if @count == 0
    data = @buffer[@head]
    @head = (@head + 1) % @size
    @count -= 1
    data
  end

  def write(data)
    raise BufferFullException if @count == @size
    @buffer[@tail] = data
    @tail = (@tail + 1) % @size
    @count += 1
  end

  def write!(data)
    if @count == @size
      @head = (@head + 1) % @size
      @count -= 1
    end
    write(data)
  end

  def clear
    @head = 0
    @tail = 0
    @count = 0
  end
end
