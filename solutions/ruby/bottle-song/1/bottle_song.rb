class BottleSong
  def self.recite(start_bottles, take_down)
    numbers = {
      10 => "Ten", 9 => "Nine", 8 => "Eight", 7 => "Seven", 6 => "Six",
      5 => "Five", 4 => "Four", 3 => "Three", 2 => "Two", 1 => "One"
    }

    verses = []
    current = start_bottles
    take_down.times do |i|
      b1 = numbers[current]
      b1_str = current > 1 ? "#{b1} green bottles" : "One green bottle"
      
      b2 = numbers[current - 1]
      
      if current > 1
        b2_str = (current - 1) == 1 ? "one green bottle" : "#{b2.downcase} green bottles"
      else
        b2_str = "no green bottles"
      end
      
      verses.push("#{b1_str} hanging on the wall,")
      verses.push("#{b1_str} hanging on the wall,")
      verses.push("And if one green bottle should accidentally fall,")
      verses.push("There'll be #{b2_str} hanging on the wall.")
      
      current -= 1
      if take_down > 1 && i < take_down - 1
        verses.push("")
      end
    end
    verses.join("\n") + "\n"
  end
end
