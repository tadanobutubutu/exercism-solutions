export const isPangram = (sentence) => {
  const letters = sentence.toLowerCase().match(/[a-z]/g) ?? [];
  return new Set(letters).size === 26;
};
