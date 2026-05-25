class Acronym
  def self.abbreviate(phrase)
    phrase.gsub(/[^a-zA-Z']/, ' ').split.map { |word| word[0].upcase }.join
  end
end