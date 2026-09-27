export function find(haystack: unknown, needle: unknown): number | never {
  if (
    !Array.isArray(haystack) ||
    typeof needle !== 'number' ||
    !haystack.every((value) => typeof value === 'number')
  ) {
    throw new Error('Value not in array')
  }

  let low = 0
  let high = haystack.length - 1

  while (low <= high) {
    const middle = Math.floor((low + high) / 2)
    const value = haystack[middle] as number
    if (value === needle) return middle
    if (value < needle) low = middle + 1
    else high = middle - 1
  }

  throw new Error('Value not in array')
}
