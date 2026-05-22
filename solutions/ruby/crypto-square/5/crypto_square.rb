class Crypto
  def initialize(text)
    @text = text.downcase.gsub(/[^a-z0-9]/, "")
  end

  def ciphertext
    return "" if @text.empty?
    
    len = @text.length
    cols = Math.sqrt(len).ceil
    
    # Transpose rows and cols
    # Split text into chunks, pad with space, then transpose
    chunks = @text.scan(/.{1,#{cols}}/m)
    padded_chunks = chunks.map { |chunk| chunk.ljust(cols, " ") }
    
    # Transpose the characters within chunks
    # We want columns of the original text
    padded_chunks.map(&:chars).transpose.map(&:join).join(" ")
  end
end
