Node = Struct.new(:value, :left, :right)

class Zipper
  def self.from_tree(tree)
    new(tree)
  end

  def initialize(tree, crumbs = [], left_tree = nil, right_tree = nil)
    @tree = tree
    @crumbs = crumbs
  end

  def value
    @tree.value
  end

  def left
    return nil unless @tree.left
    Zipper.new(@tree.left, @crumbs + [[:left, @tree.value, @tree.right]])
  end

  def right
    return nil unless @tree.right
    Zipper.new(@tree.right, @crumbs + [[:right, @tree.value, @tree.left]])
  end

  def up
    return nil if @crumbs.empty?
    dir, val, sibling = @crumbs.last
    if dir == :left
      Zipper.new(Node.new(val, @tree, sibling), @crumbs[0...-1])
    else
      Zipper.new(Node.new(val, sibling, @tree), @crumbs[0...-1])
    end
  end

  def set_value(value)
    Zipper.new(Node.new(value, @tree.left, @tree.right), @crumbs)
  end

  def set_left(tree)
    Zipper.new(Node.new(@tree.value, tree, @tree.right), @crumbs)
  end

  def set_right(tree)
    Zipper.new(Node.new(@tree.value, @tree.left, tree), @crumbs)
  end

  def to_tree
    z = self
    loop do
      u = z.up
      break unless u
      z = u
    end
    z.instance_variable_get(:@tree)
  end

  def ==(other)
    to_tree == other.to_tree
  end
end
