class Deque
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def push(value)
    node = Node.new(value)
    if @tail
      @tail.next = node
      node.prev = @tail
      @tail = node
    else
      @head = @tail = node
    end
    @size += 1
  end

  def pop
    return nil unless @tail
    value = @tail.value
    @tail = @tail.prev
    if @tail
      @tail.next = nil
    else
      @head = nil
    end
    @size -= 1
    value
  end

  def shift
    return nil unless @head
    value = @head.value
    @head = @head.next
    if @head
      @head.prev = nil
    else
      @tail = nil
    end
    @size -= 1
    value
  end

  def unshift(value)
    node = Node.new(value)
    if @head
      @head.prev = node
      node.next = @head
      @head = node
    else
      @head = @tail = node
    end
    @size += 1
  end

  def count
    @size
  end

  def delete(value)
    node = @head
    while node
      if node.value == value
        if node.prev
          node.prev.next = node.next
        else
          @head = node.next
        end
        if node.next
          node.next.prev = node.prev
        else
          @tail = node.prev
        end
        @size -= 1
        return
      end
      node = node.next
    end
  end

  Node = Struct.new(:value, :prev, :next)
end
