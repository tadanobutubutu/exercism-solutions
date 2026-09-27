export const solve = (puzzle) => {
  const [left, right] = puzzle.split('==').map((part) => part.trim());
  const addends = left.split('+').map((word) => word.trim());
  const result = right.trim();
  const words = [...addends, result];
  const letters = [...new Set(words.join(''))];
  if (letters.length > 10) return null;

  const leading = new Set(words.filter((word) => word.length > 1).map((word) => word[0]));
  const assignment = new Map();
  const used = new Set();
  const maxColumns = Math.max(...words.map((word) => word.length));

  const searchColumn = (column, carry) => {
    if (column === maxColumns) return carry === 0 ? { ...Object.fromEntries(assignment) } : null;

    const counts = new Map();
    for (const word of addends) {
      const letter = word[word.length - 1 - column];
      if (letter) counts.set(letter, (counts.get(letter) || 0) + 1);
    }
    const outputLetter = result[result.length - 1 - column];
    const unknowns = [...counts.keys()]
      .filter((letter) => !assignment.has(letter))
      .sort((a, b) => counts.get(b) - counts.get(a));

    const finishColumn = () => {
      let sum = carry;
      for (const [letter, count] of counts) sum += assignment.get(letter) * count;
      const digit = sum % 10;
      const nextCarry = Math.floor(sum / 10);

      if (!outputLetter) {
        return digit === 0 ? searchColumn(column + 1, nextCarry) : null;
      }

      if (assignment.has(outputLetter)) {
        return assignment.get(outputLetter) === digit
          ? searchColumn(column + 1, nextCarry)
          : null;
      }
      if (used.has(digit) || (digit === 0 && leading.has(outputLetter))) return null;

      assignment.set(outputLetter, digit);
      used.add(digit);
      const answer = searchColumn(column + 1, nextCarry);
      assignment.delete(outputLetter);
      used.delete(digit);
      return answer;
    };

    const assignOperands = (index) => {
      if (index === unknowns.length) return finishColumn();
      const letter = unknowns[index];
      const firstAllowed = leading.has(letter) ? 1 : 0;
      for (let digit = firstAllowed; digit <= 9; digit += 1) {
        if (used.has(digit)) continue;
        assignment.set(letter, digit);
        used.add(digit);
        const answer = assignOperands(index + 1);
        assignment.delete(letter);
        used.delete(digit);
        if (answer) return answer;
      }
      return null;
    };

    return assignOperands(0);
  };

  return searchColumn(0, 0);
};
