export const countWords = (text) => {
  const counts = {};
  const words = text.toLocaleLowerCase().match(/[\p{L}\p{N}]+(?:['’][\p{L}\p{N}]+)*/gu) ?? [];
  for (const word of words) {
    if (!Object.prototype.hasOwnProperty.call(counts, word)) counts[word] = 0;
    counts[word] += 1;
  }
  return counts;
};
