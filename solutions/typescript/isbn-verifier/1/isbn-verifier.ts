export function isValid(isbn: unknown): boolean {
  if (typeof isbn !== 'string') return false

  const digits = isbn.replace(/-/g, '')
  if (!/^[0-9]{9}[0-9X]$/.test(digits)) return false

  const values = [...digits].map((digit) => (digit === 'X' ? 10 : Number(digit)))
  const checksum = values.reduce((sum, value, index) => sum + value * (10 - index), 0)
  return checksum % 11 === 0
}
