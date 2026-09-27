//
// This is only a SKELETON file for the 'Anagram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const signature = (word) =>
  [...word.normalize('NFC').toLowerCase()].sort().join('');

export const findAnagrams = (subject, candidates) => {
  const subjectKey = signature(subject);
  const subjectLower = subject.normalize('NFC').toLowerCase();
  return candidates.filter((candidate) => {
    const lower = candidate.normalize('NFC').toLowerCase();
    return lower !== subjectLower && signature(candidate) === subjectKey;
  });
};
