class Anagram
  def initialize(word)
    @word = word.downcase
    @sorted_word = @word.chars.sort
  end

  def match(words)
    words.select do |w|
      downcased = w.downcase
      downcased != @word && downcased.chars.sort == @sorted_word
    end
  end
end
