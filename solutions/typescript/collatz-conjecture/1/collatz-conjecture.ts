export function steps(count: number): number {
  if (!Number.isInteger(count) || count <= 0) {
    throw new Error('Only positive integers are allowed')
  }

  let value = count
  let numberOfSteps = 0
  while (value !== 1) {
    value = value % 2 === 0 ? value / 2 : value * 3 + 1
    numberOfSteps += 1
  }
  return numberOfSteps
}
