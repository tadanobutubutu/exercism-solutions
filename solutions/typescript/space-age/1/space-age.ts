const ORBITAL_PERIODS: Record<string, number> = {
  mercury: 0.2408467,
  venus: 0.61519726,
  earth: 1,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132,
}

export function age(planet: string, seconds: number): number {
  const period = ORBITAL_PERIODS[planet]
  if (period === undefined) throw new Error(`Unknown planet: ${planet}`)

  const earthYears = seconds / 31_557_600
  return Number((earthYears / period).toFixed(2))
}
