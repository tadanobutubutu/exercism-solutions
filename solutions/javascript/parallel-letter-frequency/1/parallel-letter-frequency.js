//
// This is only a SKELETON file for the 'Parallel Letter Frequency' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const parallelLetterFrequency = async (texts) => {
  const partialFrequencies = await Promise.all(
    texts.map(async text => {
      await new Promise(resolve => setImmediate(resolve));
      const frequencies = {};
      for (const letter of text.toLowerCase()) {
        if (/^\p{L}$/u.test(letter)) frequencies[letter] = (frequencies[letter] ?? 0) + 1;
      }
      return frequencies;
    }),
  );

  return partialFrequencies.reduce((total, partial) => {
    for (const [letter, count] of Object.entries(partial)) {
      total[letter] = (total[letter] ?? 0) + count;
    }
    return total;
  }, {});
};
