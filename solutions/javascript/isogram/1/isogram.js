export const isIsogram = (phrase) => {
  const seen = new Set();
  for (const character of phrase.toLocaleLowerCase()) {
    if (!/\p{L}/u.test(character)) continue;
    if (seen.has(character)) return false;
    seen.add(character);
  }
  return true;
};
