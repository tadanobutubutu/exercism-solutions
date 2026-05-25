class Affine
  def initialize(a, b)
    @a = a
    @b = b
    raise ArgumentError, 'a and m must be coprime' unless coprime?(a, 26)
  end

  def encode(plaintext)
    plaintext.downcase.gsub(/[^a-z0-9]/, '').chars.map { |c| encode_char(c) }.join.scan(/.{1,5}/).join(' ')
  end

  def decode(ciphertext)
    ciphertext.gsub(/\s+/, '').chars.map { |c| decode_char(c) }.join
  end

  private

  def coprime?(a, m)
    a.gcd(m) == 1
  end

  def encode_char(c)
    if c =~ /[0-9]/ 
      c
    else
      ((@a * (c.ord - 'a'.ord) + @b) % 26 + 'a'.ord).chr
    end
  end

  def decode_char(c)
    if c =~ /[0-9]/ 
      c
    else
      ((modular_inverse(@a, 26) * (c.ord - 'a'.ord - @b)) % 26 + 'a'.ord).chr
    end
  end

  def modular_inverse(a, m)
    a, m = a % m, m
    (1..m).each do |x|
      return x if (a * x) % m == 1
    end
    raise 'Modular inverse does not exist'
  end
end