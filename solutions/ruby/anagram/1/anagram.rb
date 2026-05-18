class Anagram
  def initialize(word)
    @word = word.downcase
    @sorted_word = @word.chars.sort
  end

  def match(candidates)
    candidates.select do |candidate|
      cand_lower = candidate.downcase
      cand_lower != @word && cand_lower.chars.sort == @sorted_word
    end
  end
end
