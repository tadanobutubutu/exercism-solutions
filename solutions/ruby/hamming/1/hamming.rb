=begin
Write your code for the 'Hamming' exercise in this file. Make the tests in
`hamming_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/hamming` directory.
=end

class Hamming
  def self.compute(strand_a, strand_b)
    raise ArgumentError, 'strands must be the same length' unless strand_a.length == strand_b.length
    raise ArgumentError, 'strands must not be empty' if strand_a.empty? != strand_b.empty?

    strand_a.chars.zip(strand_b.chars).count { |left, right| left != right }
  end
end
