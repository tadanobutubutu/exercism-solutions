export const keep = (arr, fn) => {
  const result = [];
  for (const item of arr) {
    if (fn(item)) result.push(item);
  }
  return result;
};

export const discard = (arr, fn) => {
  const result = [];
  for (const item of arr) {
    if (!fn(item)) result.push(item);
  }
  return result;
};
