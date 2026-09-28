const allergens = [
  ['eggs', 1],
  ['peanuts', 2],
  ['shellfish', 4],
  ['strawberries', 8],
  ['tomatoes', 16],
  ['chocolate', 32],
  ['pollen', 64],
  ['cats', 128],
] as const

export class Allergies {
  private readonly score: number

  constructor(allergenIndex: unknown) {
    this.score =
      typeof allergenIndex === 'number' &&
      Number.isSafeInteger(allergenIndex) &&
      allergenIndex >= 0
        ? allergenIndex % 256
        : 0
  }

  public list(): string[] {
    return allergens
      .filter(([, value]) => (this.score & value) !== 0)
      .map(([name]) => name)
  }

  public allergicTo(allergen: unknown): boolean {
    return this.list().includes(String(allergen))
  }
}
