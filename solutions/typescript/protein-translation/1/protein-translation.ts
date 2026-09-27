const CODONS: Record<string, string | null> = {
  AUG: 'Methionine',
  UUU: 'Phenylalanine',
  UUC: 'Phenylalanine',
  UUA: 'Leucine',
  UUG: 'Leucine',
  UCU: 'Serine',
  UCC: 'Serine',
  UCA: 'Serine',
  UCG: 'Serine',
  UAU: 'Tyrosine',
  UAC: 'Tyrosine',
  UGU: 'Cysteine',
  UGC: 'Cysteine',
  UGG: 'Tryptophan',
  UAA: null,
  UAG: null,
  UGA: null,
}

export function translate(rna: string): string[] {
  const proteins: string[] = []
  for (let index = 0; index < rna.length; index += 3) {
    const codon = rna.slice(index, index + 3)
    if (!(codon in CODONS)) throw new Error('Invalid codon')
    const protein = CODONS[codon]
    if (protein === null) break
    if (protein === undefined) throw new Error('Invalid codon')
    proteins.push(protein)
  }
  return proteins
}
