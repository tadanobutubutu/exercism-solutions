class Luhn
  def self.valid?(string)
    cleaned = string.gsub(/\s/, '')
    return false if cleaned.length <= 1 || cleaned =~ /\D/
    
    digits = cleaned.chars.map(&:to_i).reverse
    digits.each_with_index.map do |d, i|
      if i.odd?
        d *= 2
        d -= 9 if d > 9
      end
      d
    end.sum % 10 == 0
  end
end
