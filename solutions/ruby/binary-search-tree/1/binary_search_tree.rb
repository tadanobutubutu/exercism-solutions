class Bst
  include Enumerable
  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(value)
    if value <= @data
      if @left.nil?
        @left = Bst.new(value)
      else
        @left.insert(value)
      end
    else
      if @right.nil?
        @right = Bst.new(value)
      else
        @right.insert(value)
      end
    end
  end

  def each(&block)
    return to_enum unless block_given?
    @left.each(&block) if @left
    block.call(@data)
    @right.each(&block) if @right
  end
end
