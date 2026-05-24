class Nucleotide
  def self.from_dna(strand)
    raise ArgumentError if strand.match?(/[^ACGT]/)
    new(strand)
  end

  def initialize(strand)
    @strand = strand
  end

  def histogram
    { "A" => @strand.count("A"),
      "C" => @strand.count("C"),
      "G" => @strand.count("G"),
      "T" => @strand.count("T") }
  end
end
