//
// This is only a SKELETON file for the 'Bob' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const hey = (message) => {
  const trimmed = message.trim();
  if (trimmed === '') return 'Fine. Be that way!';

  const isQuestion = trimmed.endsWith('?');
  const hasLetters = /\p{L}/u.test(trimmed);
  const isShouting = hasLetters && trimmed === trimmed.toLocaleUpperCase();

  if (isShouting && isQuestion) return "Calm down, I know what I'm doing!";
  if (isShouting) return 'Whoa, chill out!';
  if (isQuestion) return 'Sure.';
  return 'Whatever.';
};
