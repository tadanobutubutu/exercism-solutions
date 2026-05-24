class IsbnVerifier
  def self.valid?(str)
    digits = str.gsub('-', '')
    return false unless digits.match?(/\A\d{9}[\dX]\z/)
    sum = digits.chars.each_with_index.sum { |c, i|
      c == 'X' ? 10 * (10 - i) : c.to_i * (10 - i)
    }
    sum % 11 == 0
  end
end
