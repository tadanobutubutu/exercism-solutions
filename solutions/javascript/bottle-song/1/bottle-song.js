//
// This is only a SKELETON file for the 'Bottle Song' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const recite = (initialBottlesCount, takeDownCount) => {
  const words = ['no', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'];
  const countPhrase = count => words[count] ?? String(count);
  const bottleLine = count => {
    const noun = count === 1 ? 'bottle' : 'bottles';
    const phrase = countPhrase(count);
    return `${phrase[0].toUpperCase()}${phrase.slice(1)} green ${noun} hanging on the wall,`;
  };
  const lyrics = [];

  for (let verse = 0; verse < takeDownCount; verse += 1) {
    const count = initialBottlesCount - verse;
    const nextCount = count - 1;
    if (verse > 0) lyrics.push('');
    lyrics.push(
      bottleLine(count),
      bottleLine(count),
      'And if one green bottle should accidentally fall,',
      `There'll be ${countPhrase(nextCount)} green ${nextCount === 1 ? 'bottle' : 'bottles'} hanging on the wall.`,
    );
  }

  return lyrics;
};
