type Item = {
  weight: number
  value: number
}

export function maximumValue({
  maximumWeight,
  items,
}: {
  maximumWeight: number
  items: Item[]
}): number {
  const bestValues = new Array<number>(maximumWeight + 1).fill(0)
  for (const { weight, value } of items) {
    for (let capacity = maximumWeight; capacity >= weight; capacity--) {
      bestValues[capacity] = Math.max(
        bestValues[capacity],
        bestValues[capacity - weight] + value
      )
    }
  }
  return bestValues[maximumWeight]
}
