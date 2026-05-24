//
// This is only a SKELETON file for the 'Protein Translation' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const CODONS = {
  AUG: 'Methionine',
  UUU: 'Phenylalanine', UUC: 'Phenylalanine',
  UUA: 'Leucine', UUG: 'Leucine',
  UCU: 'Serine', UCC: 'Serine', UCA: 'Serine', UCG: 'Serine',
  UAU: 'Tyrosine', UAC: 'Tyrosine',
  UGU: 'Cysteine', UGC: 'Cysteine',
  UGG: 'Tryptophan',
  UAA: 'STOP', UAG: 'STOP', UGA: 'STOP',
};

export const translate = (rna) => {
  if (!rna) return [];
  const proteins = [];
  for (let i = 0; i < rna.length; i += 3) {
    const codon = rna.slice(i, i + 3);
    if (codon.length < 3) throw new Error('Invalid codon');
    const protein = CODONS[codon];
    if (!protein) throw new Error('Invalid codon');
    if (protein === 'STOP') break;
    proteins.push(protein);
  }
  return proteins;
};
