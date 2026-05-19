class Robot
  def self.name(year)
    letters = ('A'..'Z').to_a
    year_str = year.to_s.rjust(2, '0')
    
    result = year_str.chars.map do |digit|
      case digit
      when '0'
        letters.sample(2).join
      when '1'
        letters.sample(3).join
      else
        letters.sample(4).join
      end
    end.join
    
    "#{result}#{year_str[-1]}"
  end
end
