fun translate(rna: String?): List<String> {
    if (rna == null) return emptyList()

    val proteins = mutableListOf<String>()
    val translations = mapOf(
        "AUG" to "Methionine",
        "UUU" to "Phenylalanine", "UUC" to "Phenylalanine",
        "UUA" to "Leucine", "UUG" to "Leucine",
        "UCU" to "Serine", "UCC" to "Serine", "UCA" to "Serine", "UCG" to "Serine",
        "UAU" to "Tyrosine", "UAC" to "Tyrosine",
        "UGU" to "Cysteine", "UGC" to "Cysteine",
        "UGG" to "Tryptophan"
    )

    for (codon in rna.chunked(3)) {
        if (codon in setOf("UAA", "UAG", "UGA")) break
        proteins.add(translations[codon] ?: throw IllegalArgumentException("Invalid codon"))
    }
    return proteins
}
