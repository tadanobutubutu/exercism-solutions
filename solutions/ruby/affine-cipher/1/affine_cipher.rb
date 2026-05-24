class Affine
  ALPHABET = ('a'..'z').to_a
  M = 26

  def initialize(a, b)
    raise ArgumentError if a.gcd(M) != 1
    @a = a
    @b = b
    @mmi = (1..M).find { |x| (a * x) % M == 1 }
  end

  def encode(text)
    result = text.downcase.gsub(/[^a-z0-9]/, '').chars.map do |c|
      if c =~ /\d/
        c
      else
        i = ALPHABET.index(c)
        ALPHABET[(@a * i + @b) % M]
      end
    end.join
    result.chars.each_slice(5).map(&:join).join(' ')
  end

  def decode(text)
    text.gsub(/\s+/, '').chars.map do |c|
      if c =~ /\d/
        c
      else
        i = ALPHABET.index(c)
        ALPHABET[(@mmi * (i - @b)) % M]
      end
    end.join
  end
end
