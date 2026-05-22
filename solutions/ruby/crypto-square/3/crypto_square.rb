class Crypto
  def initialize(plaintext)
    @plaintext = plaintext
  end

  def normalize
    @plaintext.downcase.gsub(/[^a-z0-9]/, '')
  end

  def plaintext_segments
    return [] if normalize.empty?
    length = normalize.length
    c = Math.sqrt(length).ceil
    normalize.scan(/.{1,#{c}}/)
  end

  def ciphertext
    normalize_ciphertext
  end

  def normalize_ciphertext
    segments = plaintext_segments
    return "" if segments.empty?
    
    c = segments.first.length
    # 矩形にするためにスペースでパディング
    padded_rows = segments.map { |s| s.ljust(c, ' ') }
    
    # 転置
    columns = padded_rows.map(&:chars).transpose
    
    # 各列（column）を結合して文字列にする
    # ここで各列の文字列の末尾スペースを保持する必要がある
    # columns.map(&:join) の結果が ["clu", "hlt", "io "] となるようにする
    # その後にスペースで join する
    columns.map(&:join).join(" ")
  end
end
