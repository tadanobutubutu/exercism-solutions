export class Robot {
  private static readonly usedNames = new Set<string>()
  private static lastName: string | undefined

  private currentName: string | undefined

  public get name(): string {
    this.currentName ??= Robot.generateUniqueName()
    return this.currentName
  }

  public resetName(): void {
    this.currentName = Robot.generateUniqueName()
  }

  public static releaseNames(): void {
    Robot.usedNames.clear()
    Robot.lastName = undefined
  }

  private static generateUniqueName(): string {
    const totalNames = 26 * 26 * 1000
    if (Robot.usedNames.size >= totalNames) {
      throw new Error('No robot names are available')
    }

    const previousIndex = Robot.lastName
      ? Robot.nameIndex(Robot.lastName)
      : undefined

    while (true) {
      const firstLetter = String.fromCharCode(65 + Math.floor(Math.random() * 26))
      const secondLetter = String.fromCharCode(65 + Math.floor(Math.random() * 26))
      const number = Math.floor(Math.random() * 1000)
      const candidate = `${firstLetter}${secondLetter}${String(number).padStart(3, '0')}`

      if (Robot.usedNames.has(candidate)) continue
      if (
        previousIndex !== undefined &&
        Math.abs(Robot.nameIndex(candidate) - previousIndex) <= 1
      ) {
        continue
      }

      Robot.usedNames.add(candidate)
      Robot.lastName = candidate
      return candidate
    }
  }

  private static nameIndex(name: string): number {
    const letters = (name.charCodeAt(0) - 65) * 26 + (name.charCodeAt(1) - 65)
    return letters * 1000 + Number(name.slice(2))
  }
}
