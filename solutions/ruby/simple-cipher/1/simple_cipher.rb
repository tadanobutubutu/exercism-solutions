class Cipher
  attr_reader :key

  def initialize(key = nil)
    @key = key || (0...100).map { ('a'.ord + rand(26)).chr }.join
    raise ArgumentError unless @key.match?(/\A[a-z]+\z/)
  end

  def encode(text)
    text.chars.each_with_index.map do |c, i|
      shift = @key[i % @key.length].ord - 'a'.ord
      ((c.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
    end.join
  end

  def decode(text)
    text.chars.each_with_index.map do |c, i|
      shift = @key[i % @key.length].ord - 'a'.ord
      ((c.ord - 'a'.ord - shift) % 26 + 'a'.ord).chr
    end.join
  end
end
