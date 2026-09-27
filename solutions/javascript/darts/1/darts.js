//
// This is only a SKELETON file for the 'Darts' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const score = (x, y) => {
  const distance = Math.hypot(x, y);
  if (distance <= 1) return 10;
  if (distance <= 5) return 5;
  if (distance <= 10) return 1;
  return 0;
};
