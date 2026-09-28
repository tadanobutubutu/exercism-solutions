export function solve(puzzle: unknown): Record<string, number> | undefined {
  if (typeof puzzle !== 'string') return undefined
  const [left, right, extra] = puzzle.split('==')
  if (left === undefined || right === undefined || extra !== undefined) return undefined
  const addends = left.split('+').map((word) => word.trim())
  const result = right.trim()
  if (addends.some((word) => !/^[A-Z]+$/.test(word)) || !/^[A-Z]+$/.test(result)) {
    return undefined
  }

  const letters = new Set([...addends.join(''), ...result])
  if (letters.size > 10 || addends.some((word) => word.length > result.length)) return undefined

  const leading = new Set(
    [...addends, result].filter((word) => word.length > 1).map((word) => word[0]!)
  )
  const assigned = new Map<string, number>()
  const used = new Set<number>()

  const solveColumn = (column: number, carry: number): boolean => {
    if (column === result.length) return carry === 0

    const addDigits = (index: number, sum: number): boolean => {
      if (index < addends.length) {
        const letter = addends[index]![addends[index]!.length - 1 - column]
        if (letter === undefined) return addDigits(index + 1, sum)
        const existing = assigned.get(letter)
        if (existing !== undefined) return addDigits(index + 1, sum + existing)

        for (let digit = 0; digit <= 9; digit++) {
          if (used.has(digit) || (digit === 0 && leading.has(letter))) continue
          assigned.set(letter, digit)
          used.add(digit)
          if (addDigits(index + 1, sum + digit)) return true
          assigned.delete(letter)
          used.delete(digit)
        }
        return false
      }

      const sumDigit = sum % 10
      const nextCarry = Math.floor(sum / 10)
      const resultLetter = result[result.length - 1 - column]!
      const existing = assigned.get(resultLetter)
      if (existing !== undefined) {
        return existing === sumDigit && solveColumn(column + 1, nextCarry)
      }
      if (used.has(sumDigit) || (sumDigit === 0 && leading.has(resultLetter))) return false
      assigned.set(resultLetter, sumDigit)
      used.add(sumDigit)
      if (solveColumn(column + 1, nextCarry)) return true
      assigned.delete(resultLetter)
      used.delete(sumDigit)
      return false
    }

    return addDigits(0, carry)
  }

  if (!solveColumn(0, 0)) return undefined
  return Object.fromEntries(assigned)
}
