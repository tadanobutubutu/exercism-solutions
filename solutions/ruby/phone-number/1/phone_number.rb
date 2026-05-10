class PhoneNumber
  def self.clean(number)
    digits = number.gsub(/[^0-9a-zA-Z]/, '')
    return nil if digits =~ /[a-zA-Z]/
    
    digits = digits.gsub(/\D/, '')
    
    if digits.length == 11
      return nil unless digits.start_with?('1')
      digits = digits[1..]
    end
    
    return nil unless digits.length == 10
    
    return nil if digits[0].to_i < 2 || digits[3].to_i < 2
    
    digits
  end
end
