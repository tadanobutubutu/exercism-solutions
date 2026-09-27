export const compute = (strandA, strandB) => {
  if (strandA.length !== strandB.length) {
    throw new Error('strands must be of equal length');
  }
  let distance = 0;
  for (let index = 0; index < strandA.length; index += 1) {
    if (strandA[index] !== strandB[index]) distance += 1;
  }
  return distance;
};
