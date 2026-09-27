//
// This is only a SKELETON file for the 'RNA Transcription' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const complements = { A: 'U', C: 'G', G: 'C', T: 'A' };

export const toRna = (dna) => {
  return [...dna].map((nucleotide) => {
    const complement = complements[nucleotide];
    if (complement === undefined) throw new Error('Invalid input DNA.');
    return complement;
  }).join('');
};
