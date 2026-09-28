pub fn translate(rna: &str) -> Option<Vec<&str>> {
    let mut proteins = Vec::new();
    for codon in rna.as_bytes().chunks(3) {
        if codon.len() != 3 {
            return None;
        }
        let codon = std::str::from_utf8(codon).ok()?;
        let protein = match codon {
            "AUG" => "Methionine",
            "UUU" | "UUC" => "Phenylalanine",
            "UUA" | "UUG" => "Leucine",
            "UCU" | "UCC" | "UCA" | "UCG" => "Serine",
            "UAU" | "UAC" => "Tyrosine",
            "UGU" | "UGC" => "Cysteine",
            "UGG" => "Tryptophan",
            "UAA" | "UAG" | "UGA" => return Some(proteins),
            _ => return None,
        };
        proteins.push(protein);
    }
    Some(proteins)
}
