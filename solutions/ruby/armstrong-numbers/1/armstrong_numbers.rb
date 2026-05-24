module ArmstrongNumbers
  def self.include?(n)
    digits = n.to_s.chars.map(&:to_i)
    n == digits.sum { |d| d ** digits.length }
  end
end
