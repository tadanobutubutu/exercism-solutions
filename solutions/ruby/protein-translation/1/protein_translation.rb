class Translation
  CODONS = {
    'AUG' => 'Methionine', 'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine',
    'UUA' => 'Leucine', 'UUG' => 'Leucine',
    'UCU' => 'Serine', 'UCC' => 'Serine', 'UCA' => 'Serine', 'UCG' => 'Serine',
    'UAU' => 'Tyrosine', 'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine', 'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => 'STOP', 'UAG' => 'STOP', 'UGA' => 'STOP'
  }

  def self.of_rna(strand)
    proteins = []
    strand.chars.each_slice(3) do |triplet|
      codon = triplet.join
      raise InvalidCodonError unless CODONS.key?(codon)
      break if CODONS[codon] == 'STOP'
      proteins << CODONS[codon]
    end
    proteins
  end
end

class InvalidCodonError < ArgumentError; end
