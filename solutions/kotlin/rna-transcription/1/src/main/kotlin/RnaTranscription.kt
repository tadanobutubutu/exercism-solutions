fun transcribeToRna(dna: String): String = dna.map { nucleotide ->
    when (nucleotide) {
        'G' -> 'C'
        'C' -> 'G'
        'T' -> 'A'
        'A' -> 'U'
        else -> error("Invalid DNA nucleotide: $nucleotide")
    }
}.joinToString("")
