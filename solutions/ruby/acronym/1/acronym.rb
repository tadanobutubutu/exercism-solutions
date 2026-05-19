class Acronym
  def self.abbreviate(string)
    string.gsub(/[^a-zA-Z']/, ' ').split.map { |word| word[0] }.join.upcase
  end
end
