class Acronym
  def self.abbreviate(string)
    string.split(/[^a-zA-Z']+/).map { |word| word.delete("'")[0].upcase }.join
  end
end
