class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
    @next = nil
  end
end

class SimpleLinkedList
  def initialize(array = nil)
    @head = nil
    if array
      array.to_a.each { |e| push(Element.new(e)) }
    end
  end

  def push(element)
    element.next = @head
    @head = element
    self
  end

  def pop
    return nil unless @head
    element = @head
    @head = @head.next
    element
  end

  def to_a
    result = []
    current = @head
    while current
      result << current.datum
      current = current.next
    end
    result
  end

  def reverse!
    prev = nil
    current = @head
    while current
      nxt = current.next
      current.next = prev
      prev = current
      current = nxt
    end
    @head = prev
    self
  end
end
