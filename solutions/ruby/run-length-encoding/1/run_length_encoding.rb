class RunLengthEncoding
  def self.encode(input)
    input.gsub(/(.)\1*/) { |m| m.length > 1 ? "#{m.length}#{m[0]}" : m[0] }
  end

  def self.decode(input)
    input.gsub(/(\d+)(.)/) { $2 * $1.to_i }
  end
end
