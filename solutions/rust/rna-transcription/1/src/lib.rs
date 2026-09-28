#[derive(Debug, PartialEq, Eq)]
pub struct Dna(String);

#[derive(Debug, PartialEq, Eq)]
pub struct Rna(String);

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        for (index, nucleotide) in dna.char_indices() {
            if !matches!(nucleotide, 'A' | 'C' | 'G' | 'T') {
                return Err(index);
            }
        }
        Ok(Self(dna.to_owned()))
    }

    pub fn into_rna(self) -> Rna {
        Rna(self.0.chars().map(|nucleotide| match nucleotide {
            'A' => 'U',
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            _ => unreachable!(),
        }).collect())
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        for (index, nucleotide) in rna.char_indices() {
            if !matches!(nucleotide, 'A' | 'C' | 'G' | 'U') {
                return Err(index);
            }
        }
        Ok(Self(rna.to_owned()))
    }
}
