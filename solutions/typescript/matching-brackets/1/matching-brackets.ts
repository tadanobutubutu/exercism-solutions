export function isPaired(input: unknown): boolean {
  if (typeof input !== 'string') return false
  const stack: string[] = []
  const opening = new Set(['(', '[', '{'])
  const closingToOpening: Record<string, string> = { ')': '(', ']': '[', '}': '{' }

  for (const character of input) {
    if (opening.has(character)) {
      stack.push(character)
    } else if (character in closingToOpening) {
      if (stack.pop() !== closingToOpening[character]) return false
    }
  }
  return stack.length === 0
}
