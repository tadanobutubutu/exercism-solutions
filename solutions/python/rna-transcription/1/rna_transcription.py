def to_rna(dna_strand):
    mapping = str.maketrans("GCTA", "CGAU")
    return dna_strand.translate(mapping)
