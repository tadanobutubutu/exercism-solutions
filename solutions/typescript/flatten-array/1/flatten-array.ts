export function flatten(input: unknown): unknown[] {
  const result: unknown[] = []
  const visit = (value: unknown): void => {
    if (value === null || value === undefined) return
    if (Array.isArray(value)) {
      for (const item of value) visit(item)
    } else {
      result.push(value)
    }
  }
  visit(input)
  return result
}
