class House
  NOUNS = [
    ['house', 'that Jack built'],
    ['malt', 'that lay in'],
    ['rat', 'that ate'],
    ['cat', 'that killed'],
    ['dog', 'that worried'],
    ['cow with the crumpled horn', 'that tossed'],
    ['maiden all forlorn', 'that milked'],
    ['man all tattered and torn', 'that kissed'],
    ['priest all shaven and shorn', 'that married'],
    ['rooster that crowed in the morn', 'that woke'],
    ['farmer sowing his corn', 'that kept'],
    ['horse and the hound and the horn', 'that belonged to'],
  ]

  def self.recite(start, finish)
    (start..finish).map { |i| verse(i) }.join("\n") + "\n"
  end

  def self.verse(n)
    phrase = NOUNS.take(n).reduce(nil) { |acc, (noun, action)|
      if acc
        "the #{noun} #{action} #{acc}"
      else
        "the #{noun} #{action}"
      end
    }
    "This is #{phrase}."
  end
end
