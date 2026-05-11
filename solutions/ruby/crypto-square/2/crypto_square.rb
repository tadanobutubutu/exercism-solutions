class Crypto
  def initialize(plaintext)
    @plaintext = plaintext
  end
  
  def plaintext_segments
    normalized = @plaintext.downcase.gsub(/[^a-z0-9]/, '')
    return [normalized] if normalized.empty?
    
    size = Math.sqrt(normalized.length).ceil
    size = 1 if size == 0
    
    segments = []
    normalized.chars.each_slice(size) do |segment|
      segments << segment.join
    end
    
    segments
  end
  
  def ciphertext
    normalized = @plaintext.downcase.gsub(/[^a-z0-9]/, '')
    return "" if normalized.empty?
    
    size = Math.sqrt(normalized.length).ceil
    size = 1 if size == 0
    
    # Pad with spaces to make it rectangular
    padded = normalized.ljust(size * size)
    
    # Read column by column
    result = ""
    (0...size).each do |col|
      (0...size).each do |row|
        index = row * size + col
        result += padded[index] if index < padded.length
      end
    end
    
    result
  end
  
  def normalize_ciphertext
    normalized = @plaintext.downcase.gsub(/[^a-z0-9]/, '')
    return "" if normalized.empty?
    
    size = Math.sqrt(normalized.length).ceil
    size = 1 if size == 0
    
    # Pad with spaces to make it rectangular
    padded = normalized.ljust(size * size)
    
    # Read column by column and group
    segments = []
    (0...size).each do |col|
      segment = ""
      (0...size).each do |row|
        index = row * size + col
        segment += padded[index] if index < padded.length
      end
      segments << segment
    end
    
    segments.join(" ")
  end
end
