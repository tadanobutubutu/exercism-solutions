export class Anagram {
  private readonly normalizedInput: string
  private readonly signature: string

  constructor(input: unknown) {
    this.normalizedInput = typeof input === 'string' ? input.toLowerCase() : ''
    this.signature = this.createSignature(this.normalizedInput)
  }

  public matches(...potentials: unknown[]): string[] {
    return potentials.filter(
      (potential): potential is string =>
        typeof potential === 'string' &&
        potential.toLowerCase() !== this.normalizedInput &&
        this.createSignature(potential.toLowerCase()) === this.signature
    )
  }

  private createSignature(word: string): string {
    return [...word].sort().join('\0')
  }
}
