class CircularBuffer
  class BufferFullException < StandardError; end
  class BufferEmptyException < StandardError; end

  def initialize(capacity)
    raise ArgumentError, 'capacity must be positive' unless capacity.positive?

    @capacity = capacity
    @buffer = Array.new(capacity)
    @read_index = 0
    @write_index = 0
    @size = 0
  end

  def write(value)
    return if value.nil?
    raise BufferFullException if @size == @capacity

    @buffer[@write_index] = value
    @write_index = (@write_index + 1) % @capacity
    @size += 1
    nil
  end

  def write!(value)
    return if value.nil?

    if @size == @capacity
      @buffer[@write_index] = value
      @write_index = (@write_index + 1) % @capacity
      @read_index = (@read_index + 1) % @capacity
    else
      write(value)
    end
    nil
  end

  def read
    raise BufferEmptyException if @size.zero?

    value = @buffer[@read_index]
    @buffer[@read_index] = nil
    @read_index = (@read_index + 1) % @capacity
    @size -= 1
    value
  end

  def clear
    @buffer = Array.new(@capacity)
    @read_index = @write_index = @size = 0
  end
end
