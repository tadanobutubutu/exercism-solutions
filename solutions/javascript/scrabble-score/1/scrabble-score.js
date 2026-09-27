const letterScores = Object.fromEntries(
  [
    ['AEIOULNRST', 1],
    ['DG', 2],
    ['BCMP', 3],
    ['FHVWY', 4],
    ['K', 5],
    ['JX', 8],
    ['QZ', 10],
  ].flatMap(([letters, value]) =>
    Array.from(letters, (letter) => [letter, value]),
  ),
);

export const score = (word) =>
  Array.from(word.toUpperCase()).reduce(
    (total, letter) => total + (letterScores[letter] ?? 0),
    0,
  );
