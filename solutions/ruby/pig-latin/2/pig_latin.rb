class PigLatin
  def self.translate(phrase)
    words = phrase.split(' ')
    words.map { |word| translate_word(word) }.join(' ')
  end
  
  def self.translate_word(word)
    return word if word.empty?
    
    vowels = %w[a e i o u]
    
    if vowels.include?(word[0])
      return word + 'ay'
    end
    
    # Handle consonant clusters
    consonant_cluster = word.match(/^([^aeiou]+)(.*)/)
    if consonant_cluster
      return consonant_cluster[2] + consonant_cluster[1] + 'ay'
    end
    
    word + 'ay'
  end
end
