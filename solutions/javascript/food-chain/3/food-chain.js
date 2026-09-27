//
// This is only a SKELETON file for the 'Food Chain' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const animals = ['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse'];
const introductoryLines = [
  '',
  'It wriggled and jiggled and tickled inside her.',
  'How absurd to swallow a bird!',
  'Imagine that, to swallow a cat!',
  'What a hog, to swallow a dog!',
  'Just opened her throat and swallowed a goat!',
  "I don't know how she swallowed a cow!",
  "She's dead, of course!",
];

export class Song {
  verse(number) {
    let result = `I know an old lady who swallowed a ${animals[number - 1]}.\n`;
    if (number === 8) return `${result}${introductoryLines[7]}\n`;
    if (number === 2) result += 'It wriggled and jiggled and tickled inside her.\n';
    else if (number > 2) result += `${introductoryLines[number - 1]}\n`;
    for (let i = number - 1; i > 0; i -= 1) {
      const line =
        i === 1
          ? 'She swallowed the spider to catch the fly.'
          : i === 2
            ? 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.'
            : `She swallowed the ${animals[i]} to catch the ${animals[i - 1]}.`;
      result += `${line}\n`;
    }
    return `${result}I don't know why she swallowed the fly. Perhaps she'll die.\n`;
  }

  verses(start, end) {
    return `${Array.from({ length: end - start + 1 }, (_, i) => this.verse(start + i)).join('\n')}\n`;
  }
}
