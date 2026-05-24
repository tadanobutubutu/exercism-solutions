class Brackets
  PAIRS = { '[' => ']', '{' => '}', '(' => ')' }

  def self.paired?(str)
    stack = []
    str.each_char do |c|
      if PAIRS.key?(c)
        stack.push(c)
      elsif PAIRS.values.include?(c)
        return false if stack.empty? || PAIRS[stack.pop] != c
      end
    end
    stack.empty?
  end
end
