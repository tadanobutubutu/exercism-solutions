use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if !matches!(nucleotide, 'A' | 'C' | 'G' | 'T') {
        return Err(nucleotide);
    }
    for base in dna.chars() {
        if !matches!(base, 'A' | 'C' | 'G' | 'T') {
            return Err(base);
        }
    }
    Ok(dna.chars().filter(|&base| base == nucleotide).count())
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut counts = HashMap::from([('A', 0), ('C', 0), ('G', 0), ('T', 0)]);
    for base in dna.chars() {
        let Some(count) = counts.get_mut(&base) else {
            return Err(base);
        };
        *count += 1;
    }
    Ok(counts)
}
