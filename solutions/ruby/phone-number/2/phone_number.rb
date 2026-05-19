class PhoneNumber
  def self.clean(number)
    cleaned = number.gsub(/[^0-9]/, '')
    
    if cleaned.length == 11 && cleaned.start_with?('1')
      cleaned = cleaned[1..-1]
    end
    
    return '0000000000' unless cleaned.length == 10
    return '0000000000' if cleaned[0] == '0' || cleaned[0] == '1'
    return '0000000000' if cleaned[3] == '0' || cleaned[3] == '1'
    
    cleaned
  end
end
