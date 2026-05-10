module PigLatin
  def self.translate(phrase)
    phrase.split.map { |word| translate_word(word) }.join(' ')
  end

  def self.translate_word(word)
    if word =~ /\A([aeiou]|xr|yt)/
      word + 'ay'
    elsif word =~ /\A([^aeiou]*qu)(.*)\z/
      $2 + $1 + 'ay'
    elsif word =~ /\A([^aeiou]+)(y.*)\z/
      $2 + $1 + 'ay'
    elsif word =~ /\A([^aeiou]+)(.*)\z/
      $2 + $1 + 'ay'
    else
      word + 'ay'
    end
  end
end
