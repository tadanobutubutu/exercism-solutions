class Diamond
  def self.make_diamond(letter)
    return "A\n" if letter == "A"
    
    letters = ("A"..letter).to_a
    n = letters.length
    width = 2 * n - 1
    
    rows = []
    
    # 上半分と中段
    letters.each_with_index do |l, i|
      if i == 0
        rows << l.center(width)
      else
        row = l + (" " * (2 * i - 1)) + l
        rows << row.center(width)
      end
    end
    
    # 下半分
    letters[0...-1].reverse_each do |l|
      i = letters.index(l)
      if i == 0
        rows << l.center(width)
      else
        row = l + (" " * (2 * i - 1)) + l
        rows << row.center(width)
      end
    end
    
    rows.join("\n") + "\n"
  end
end
