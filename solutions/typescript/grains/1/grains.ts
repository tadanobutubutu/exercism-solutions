export const square = (position: number): bigint => {
  if (!Number.isInteger(position) || position < 1 || position > 64) {
    throw new Error('square must be between 1 and 64')
  }
  return 1n << BigInt(position - 1)
}

export const total = (): bigint => {
  return (1n << 64n) - 1n
}
