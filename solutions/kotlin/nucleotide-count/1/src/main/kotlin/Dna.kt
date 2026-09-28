class Dna(dnaStrand: String) {
    init {
        require(dnaStrand.all { it in "ACGT" }) { "DNA strand contains an invalid nucleotide" }
    }

    val nucleotideCounts: Map<Char, Int> = mapOf(
        'A' to dnaStrand.count { it == 'A' },
        'C' to dnaStrand.count { it == 'C' },
        'G' to dnaStrand.count { it == 'G' },
        'T' to dnaStrand.count { it == 'T' },
    )
}
