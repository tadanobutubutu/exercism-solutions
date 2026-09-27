export const transform = (legacy) =>
  Object.entries(legacy).reduce((scores, [score, letters]) => {
    for (const letter of letters) scores[letter.toLowerCase()] = Number(score);
    return scores;
  }, {});
