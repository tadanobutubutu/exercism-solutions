class Proverb
  def initialize(*args, qualifier: nil)
    @list = args
    @qualifier = qualifier
  end

  def to_s
    return "" if @list.empty?
    
    result = ""
    (0...@list.length - 1).each do |i|
      result += "For want of a #{@list[i]} the #{@list[i+1]} was lost.\n"
    end
    
    last = @qualifier ? "#{@qualifier} #{@list[0]}" : @list[0]
    result += "And all for the want of a #{last}."
    result
  end
end
