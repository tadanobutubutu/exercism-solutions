class Atbash
  PLAIN = ('a'..'z').to_a.join
  CIPHER = PLAIN.reverse

  def self.encode(text)
    result = text.downcase.gsub(/[^a-z0-9]/, '').tr(PLAIN, CIPHER)
    result.chars.each_slice(5).map(&:join).join(' ')
  end

  def self.decode(text)
    text.gsub(/\s/, '').tr(CIPHER, PLAIN)
  end
end
