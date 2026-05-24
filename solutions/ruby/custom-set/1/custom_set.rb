class CustomSet
  def initialize(elements)
    @elements = elements.uniq
  end

  def empty?
    @elements.empty?
  end

  def member?(element)
    @elements.include?(element)
  end

  def subset?(other)
    @elements.all? { |e| other.member?(e) }
  end

  def disjoint?(other)
    @elements.none? { |e| other.member?(e) }
  end

  def eql?(other)
    @elements.sort == other.to_a.sort
  end

  def ==(other)
    eql?(other)
  end

  def add(element)
    @elements << element unless @elements.include?(element)
    self
  end

  def intersection(other)
    CustomSet.new(@elements.select { |e| other.member?(e) })
  end

  def difference(other)
    CustomSet.new(@elements.reject { |e| other.member?(e) })
  end

  def union(other)
    CustomSet.new(@elements + other.to_a)
  end

  def to_a
    @elements.dup
  end
end
