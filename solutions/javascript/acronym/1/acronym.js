export const parse = (phrase) => {
  const words = phrase.match(/\p{L}+(?:['’]\p{L}+)*/gu) ?? [];
  return words.map((word) => Array.from(word)[0].toLocaleUpperCase()).join('');
};
