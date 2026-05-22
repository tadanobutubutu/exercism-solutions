class Bob
  def self.hey(remark)
    remark = remark.strip
    if remark.empty?
      "Fine. Be that way!"
    elsif remark.end_with?("?")
      if remark.upcase == remark && remark.downcase != remark
        "Calm down, I know what I'm doing!"
      else
        "Sure."
      end
    elsif remark.upcase == remark && remark.downcase != remark
      "Whoa, chill out!"
    else
      "Whatever."
    end
  end
end
