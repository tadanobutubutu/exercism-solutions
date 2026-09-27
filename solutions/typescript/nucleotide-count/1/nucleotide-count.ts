export function nucleotideCounts(strand: string): Record<'A' | 'C' | 'G' | 'T', number> {
  const counts: Record<'A' | 'C' | 'G' | 'T', number> = {
    A: 0,
    C: 0,
    G: 0,
    T: 0,
  }

  for (const nucleotide of strand) {
    if (!(nucleotide in counts)) {
      throw new Error('Invalid nucleotide in strand')
    }
    counts[nucleotide as keyof typeof counts] += 1
  }

  return counts
}
