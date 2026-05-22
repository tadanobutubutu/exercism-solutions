class Luhn
  def self.valid?(number)
    stripped = number.gsub(" ", "")
    return false if stripped.length <= 1
    return false if stripped.match?(/\D/)
    digits = stripped.chars.map(&:to_i)
    (digits.length - 2).step(0, -2) do |i|
      digits[i] *= 2
      digits[i] -= 9 if digits[i] > 9
    end
    digits.sum % 10 == 0
  end
end