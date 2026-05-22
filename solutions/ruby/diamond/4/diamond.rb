class Diamond
  def self.make_diamond(letter)
    return "A\n" if letter == "A"
    letters = ("A"..letter).to_a
    width = letters.length * 2 - 1
    lines = letters.each_with_index.map do |l, i|
      if i == 0
        l.center(width)
      else
        (l + " " * (i * 2 - 1) + l).center(width)
      end
    end
    (lines + lines[0..-2].reverse).join("\n") + "\n"
  end
end