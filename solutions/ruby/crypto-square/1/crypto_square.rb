class Crypto
  def initialize(plaintext)
    @plaintext = plaintext
  end

  def ciphertext
    normalized = @plaintext.downcase.gsub(/[^a-z0-9]/, '')
    return '' if normalized.empty?

    l = normalized.length
    c = Math.sqrt(l).ceil
    r = (l.to_f / c).ceil

    rows = normalized.chars.each_slice(c).map(&:join)
    rows[-1] = rows[-1].ljust(c) if rows.any?
    
    # 実際には r 行必要だが、最後の行が足りない場合がある
    # columns は c 個必要。各 column は r 文字。
    
    padded = normalized.ljust(r * c)
    rect = padded.chars.each_slice(c).to_a
    
    rect.transpose.map(&:join).join(' ')
  end
end
