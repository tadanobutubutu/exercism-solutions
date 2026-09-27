export const recite = (
  initialBottleCount: unknown,
  takeDownCount: unknown
): string[] => {
  if (
    typeof initialBottleCount !== 'number' ||
    !Number.isInteger(initialBottleCount) ||
    initialBottleCount < 1 ||
    initialBottleCount > 10 ||
    typeof takeDownCount !== 'number' ||
    !Number.isInteger(takeDownCount) ||
    takeDownCount < 0
  ) {
    return []
  }

  const names = [
    'no',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
  ]
  const verses: string[] = []
  const count = Math.min(takeDownCount, initialBottleCount)

  for (let bottleCount = initialBottleCount; bottleCount > initialBottleCount - count; bottleCount--) {
    const current = names[bottleCount]
    const next = names[bottleCount - 1]
    const currentNoun = bottleCount === 1 ? 'bottle' : 'bottles'
    const nextNoun = bottleCount - 1 === 1 ? 'bottle' : 'bottles'
    if (verses.length > 0) verses.push('')
    verses.push(
      `${current} green ${currentNoun} hanging on the wall,`,
      `${current} green ${currentNoun} hanging on the wall,`,
      `And if one green bottle should accidentally fall,`,
      `There'll be ${next.toLowerCase()} green ${nextNoun} hanging on the wall.`
    )
  }
  return verses
}
