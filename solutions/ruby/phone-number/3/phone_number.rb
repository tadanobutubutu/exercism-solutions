class PhoneNumber
  def self.clean(number)
    # Remove all non-digit characters
    cleaned = number.gsub(/[^0-9]/, '')
    
    # 11桁で1で始まる場合は最初の1を除外
    if cleaned.length == 11 && cleaned[0] == '1'
      cleaned = cleaned[1..-1]
    end
    
    # ここで10桁じゃないものは不正
    return nil unless cleaned.length == 10
    
    # Area codeは0または1で始まらない
    # Exchange codeは0または1で始まらない
    return nil if cleaned[0] == '0' || cleaned[0] == '1'
    return nil if cleaned[3] == '0' || cleaned[3] == '1'
    
    cleaned
  end
end
