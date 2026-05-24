class RailFenceCipher
  def self.encode(text, rails)
    return text if rails == 1
    fence = Array.new(rails) { [] }
    row = 0
    step = 1
    text.each_char do |c|
      fence[row] << c
      row += step
      step = -step if row == 0 || row == rails - 1
    end
    fence.join
  end

  def self.decode(cipher, rails)
    return cipher if rails == 1
    pattern = rail_pattern(cipher.length, rails)
    counts = Array.new(rails, 0)
    pattern.each { |r| counts[r] += 1 }
    rail_chars = []
    pos = 0
    counts.each do |cnt|
      rail_chars << cipher[pos, cnt].chars
      pos += cnt
    end
    ptrs = Array.new(rails, 0)
    result = ""
    pattern.each do |r|
      result << rail_chars[r][ptrs[r]]
      ptrs[r] += 1
    end
    result
  end

  def self.rail_pattern(length, rails)
    pattern = []
    row = 0
    step = 1
    length.times do
      pattern << row
      row += step
      step = -step if row == 0 || row == rails - 1
    end
    pattern
  end
end
