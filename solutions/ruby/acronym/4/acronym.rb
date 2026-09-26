class Acronym
  def self.abbreviate(phrase)
    phrase.scan(/[[:alnum:]]+/).map { |word| word[0] }.join.upcase
  end
end
