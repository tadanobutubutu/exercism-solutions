const normalizeAngle = (angle) => {
  const normalized = ((angle % 360) + 360) % 360;
  return normalized === 360 ? 0 : normalized;
};

export const findSequence = (start, prisms) => {
  const sequence = [];
  let x = start.x;
  let y = start.y;
  let angle = normalizeAngle(start.angle);
  const seenStates = new Set();

  while (true) {
    const radians = (angle * Math.PI) / 180;
    const dx = Math.cos(radians);
    const dy = Math.sin(radians);
    let nearest;
    let nearestDistance = Infinity;

    for (const prism of prisms) {
      const vx = prism.x - x;
      const vy = prism.y - y;
      const distance = vx * dx + vy * dy;
      if (distance <= 1e-9 || distance >= nearestDistance) continue;

      const cross = vx * dy - vy * dx;
      const tolerance = 1e-3 * Math.max(1, Math.hypot(vx, vy));
      if (Math.abs(cross) <= tolerance) {
        nearest = prism;
        nearestDistance = distance;
      }
    }

    if (!nearest) return sequence;

    const state = `${nearest.id}:${normalizeAngle(angle).toFixed(8)}`;
    if (seenStates.has(state)) return sequence;
    seenStates.add(state);

    sequence.push(nearest.id);
    x = nearest.x;
    y = nearest.y;
    angle = normalizeAngle(angle + nearest.angle);
  }
};
