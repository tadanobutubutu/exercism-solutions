class Alphametics
  def self.solve(puzzle)
    left, right = puzzle.split(' == ')
    left_words = left.split(' + ')
    right_words = right.split(' + ') # Just in case there are multiple right words

    words = left_words + right_words
    letters = words.join.chars.uniq
    first_letters = words.map { |w| w[0] }.uniq

    weights = Hash.new(0)
    left_words.each do |word|
      word.reverse.chars.each_with_index do |char, i|
        weights[char] += 10**i
      end
    end
    right_words.each do |word|
      word.reverse.chars.each_with_index do |char, i|
        weights[char] -= 10**i
      end
    end

    # letters.sort_by to put first_letters first might help?
    # Actually, we need to find a combination of 0..9 for these letters.
    
    sorted_letters = letters.sort_by { |l| first_letters.include?(l) ? 0 : 1 }
    first_indices = sorted_letters.map.with_index { |l, i| i if first_letters.include?(l) }.compact
    
    letter_weights = sorted_letters.map { |l| weights[l] }

    (0..9).to_a.permutation(letters.size) do |p|
      next if first_indices.any? { |i| p[i] == 0 }
      
      sum = 0
      i = 0
      while i < letter_weights.size
        sum += p[i] * letter_weights[i]
        i += 1
      end

      if sum == 0
        return sorted_letters.zip(p).to_h
      end
    end

    {}
  end
end
