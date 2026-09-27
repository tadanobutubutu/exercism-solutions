//
// This is only a SKELETON file for the 'Pig Latin' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const translateWord = (word) => {
  if (/^(?:[aeiou]|xr|yt)/.test(word)) return `${word}ay`;
  let splitAt = 0;
  while (splitAt < word.length) {
    if (word.slice(splitAt).startsWith('qu')) {
      splitAt += 2;
      continue;
    }
    const char = word[splitAt];
    if ('aeiou'.includes(char) || (char === 'y' && splitAt > 0)) break;
    splitAt += 1;
  }
  return `${word.slice(splitAt)}${word.slice(0, splitAt)}ay`;
};

export const translate = (phrase) =>
  phrase === ''
    ? ''
    : phrase
    .split(/(\s+)/)
    .map((part) => (/^\s+$/.test(part) ? part : translateWord(part)))
    .join('');
