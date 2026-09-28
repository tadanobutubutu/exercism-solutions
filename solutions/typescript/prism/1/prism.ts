type Point = { x: number; y: number }
type Start = Point & { angle: number }
type Prism = Point & { id: number; angle: number }

const HIT_TOLERANCE = 0.01
const MAX_REFRACTIONS = 10000

export function findSequence(start: Start, prisms: Prism[]): number[] {
  let x = start.x
  let y = start.y
  let angle = (start.angle * Math.PI) / 180
  const sequence: number[] = []

  for (let step = 0; step < MAX_REFRACTIONS; step++) {
    const dx = Math.cos(angle)
    const dy = Math.sin(angle)
    let nearest: Prism | undefined
    let nearestDistance = Number.POSITIVE_INFINITY

    for (const prism of prisms) {
      const offsetX = prism.x - x
      const offsetY = prism.y - y
      const distance = offsetX * dx + offsetY * dy
      if (distance <= 1e-9 || distance >= nearestDistance) continue

      const perpendicularDistance = Math.abs(offsetX * dy - offsetY * dx)
      if (perpendicularDistance <= HIT_TOLERANCE) {
        nearest = prism
        nearestDistance = distance
      }
    }

    if (!nearest) break
    sequence.push(nearest.id)
    x = nearest.x
    y = nearest.y
    angle += (nearest.angle * Math.PI) / 180
  }

  return sequence
}
