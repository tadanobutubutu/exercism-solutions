class Pangram
  def self.pangram?(phrase)
    ('a'..'z').all? { |char| phrase.downcase.include?(char) }
  end
end
