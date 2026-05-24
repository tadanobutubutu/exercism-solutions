const VOWELS = 'aeiou';

function translateWord(word) {
  if (/^[aeiou]|^xr|^yt/.test(word)) {
    return word + 'ay';
  }

  let cluster = '';
  let i = 0;

  if (word[0] === 'y') {
    cluster += 'y';
    i = 1;
  }

  while (i < word.length) {
    if (word.slice(i, i + 2) === 'qu') {
      cluster += 'qu';
      i += 2;
    } else if (word[i] === 'y') {
      break;
    } else if (!VOWELS.includes(word[i])) {
      cluster += word[i];
      i++;
    } else {
      break;
    }
  }

  return word.slice(i) + cluster + 'ay';
}

export const translate = (phrase) => {
  return phrase.split(' ').map(translateWord).join(' ');
};
