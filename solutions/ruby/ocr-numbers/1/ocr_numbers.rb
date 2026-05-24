class OcrNumbers
  DIGITS = {
    [' _ ', '| |', '|_|', '   '] => '0',
    ['   ', '  |', '  |', '   '] => '1',
    [' _ ', ' _|', '|_ ', '   '] => '2',
    [' _ ', ' _|', ' _|', '   '] => '3',
    ['   ', '|_|', '  |', '   '] => '4',
    [' _ ', '|_ ', ' _|', '   '] => '5',
    [' _ ', '|_ ', '|_|', '   '] => '6',
    [' _ ', '  |', '  |', '   '] => '7',
    [' _ ', '|_|', '|_|', '   '] => '8',
    [' _ ', '|_|', ' _|', '   '] => '9',
  }

  def self.convert(input)
    lines = input.split("\n")
    raise ArgumentError if lines.length % 4 != 0
    raise ArgumentError if lines[0].length % 3 != 0

    lines.each_slice(4).map { |rows|
      (0...rows[0].length).step(3).map { |col|
        digit = rows.map { |r| r[col, 3] }
        DIGITS[digit] || '?'
      }.join
    }.join(',')
  end
end
