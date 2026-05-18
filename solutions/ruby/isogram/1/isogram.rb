class Isogram
  def self.isogram?(string)
    cleaned = string.downcase.scan(/[a-z]/)
    cleaned.uniq.length == cleaned.length
  end
end
