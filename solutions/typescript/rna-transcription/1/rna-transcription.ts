export function toRna(dna: string): string {
  const complement: Record<string, string> = {
    A: 'U',
    C: 'G',
    G: 'C',
    T: 'A',
  }

  let rna = ''
  for (const nucleotide of dna) {
    const transcribed = complement[nucleotide]
    if (transcribed === undefined) throw new Error('Invalid input DNA.')
    rna += transcribed
  }
  return rna
}
