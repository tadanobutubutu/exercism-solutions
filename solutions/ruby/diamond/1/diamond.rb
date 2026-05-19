class Diamond
  def self.make_diamond(letter)
    return "A\n" if letter == "A"
    
    letters = ('A'..letter).to_a
    width = letters.length * 2 - 1
    
    top_half = letters.map do |l|
      spaces = width / 2 - letters.index(l)
      line = " " * spaces + l
      line += " " * (width - line.length - 1) + l if l != 'A'
      line.ljust(width)
    end
    
    result = top_half.join("\n") + "\n"
    result += top_half[0..-2].reverse.join("\n") + "\n" if top_half.length > 1
    result
  end
end
