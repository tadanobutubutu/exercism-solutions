class Isogram
  def self.isogram?(input)
    letters = input.downcase.scan(/[a-z]/)
    letters == letters.uniq
  end
end