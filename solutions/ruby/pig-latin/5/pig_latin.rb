class PigLatin
  def self.translate(phrase)
    phrase.split(' ').map { |word| translate_word(word) }.join(' ')
  end

  def self.translate_word(word)
    # Rules:
    # 1. Starts with vowel: a, e, i, o, u or xr, yt
    # 2. Consonant(s) + y (as vowel)
    # 3. Consonant(s) + qu
    # 4. Consonant cluster
    
    # Check Rule 1
    return word + "ay" if word =~ /\A(xr|yt|[aeiou])/i
    
    # Check Rule 3: qu must be treated as a unit, potentially after consonants
    # Pattern: ^([^aeiou]*qu)(.*)
    if match = word.match(/\A([^aeiou]*qu)(.*)/i)
      return match[2] + match[1] + "ay"
    end
    
    # Check Rule 2: 'y' as vowel
    # 'y' is a vowel if it's NOT at the start of the word
    # BUT wait, the rule says "y is treated like a vowel at the end of a consonant cluster"
    # Actually, in 'rhythm', 'y' is the vowel. 'th' + 'y' + 'thm'
    # My simple logic should be: find the first vowel sound.
    # The first vowel sound is at the start (Rule 1), or after the consonant cluster.
    
    # Let's find the position of the first vowel.
    # Vowels: a, e, i, o, u, AND y if not at start.
    
    vowel_idx = word.downcase.index(/[aeiou]/)
    y_idx = word.downcase.index(/y/)
    
    # Y is a vowel if it is not the first letter.
    if y_idx && y_idx > 0
      if vowel_idx.nil? || y_idx < vowel_idx
        vowel_idx = y_idx
      end
    end
    
    if vowel_idx.nil?
      # No vowels found (or no vowel sound found). Move all consonants to back
      return word + "ay"
    end
    
    # Split at vowel_idx
    word[vowel_idx..-1] + word[0...vowel_idx] + "ay"
  end
end
