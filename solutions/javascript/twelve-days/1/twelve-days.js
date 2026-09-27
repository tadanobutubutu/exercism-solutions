//
// This is only a SKELETON file for the 'Twelve Days' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const ordinals = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
  'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth',
];
const gifts = [
  'a Partridge in a Pear Tree.', 'two Turtle Doves', 'three French Hens',
  'four Calling Birds', 'five Gold Rings', 'six Geese-a-Laying',
  'seven Swans-a-Swimming', 'eight Maids-a-Milking', 'nine Ladies Dancing',
  'ten Lords-a-Leaping', 'eleven Pipers Piping', 'twelve Drummers Drumming',
];

const verse = (day) => {
  const list = gifts.slice(0, day).reverse();
  const presentList = list.length === 1
    ? list[0]
    : `${list.slice(0, -1).join(', ')}, and ${list.at(-1)}`;
  return `On the ${ordinals[day - 1]} day of Christmas my true love gave to me: ${presentList}\n`;
};

export const recite = (startVerse, endVerse = startVerse) => {
  return Array.from({ length: endVerse - startVerse + 1 }, (_, offset) =>
    verse(startVerse + offset)).join('\n');
};
