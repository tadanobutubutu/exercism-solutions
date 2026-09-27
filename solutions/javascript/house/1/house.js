//
// This is only a SKELETON file for the 'House' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const chain = [
  { subject: 'malt', action: 'that lay in the house that Jack built.' },
  { subject: 'rat', action: 'that ate the malt' },
  { subject: 'cat', action: 'that killed the rat' },
  { subject: 'dog', action: 'that worried the cat' },
  { subject: 'cow with the crumpled horn', action: 'that tossed the dog' },
  { subject: 'maiden all forlorn', action: 'that milked the cow with the crumpled horn' },
  { subject: 'man all tattered and torn', action: 'that kissed the maiden all forlorn' },
  { subject: 'priest all shaven and shorn', action: 'that married the man all tattered and torn' },
  { subject: 'rooster that crowed in the morn', action: 'that woke the priest all shaven and shorn' },
  { subject: 'farmer sowing his corn', action: 'that kept the rooster that crowed in the morn' },
  { subject: 'horse and the hound and the horn', action: 'that belonged to the farmer sowing his corn' },
];

export class House {
  static verse(number) {
    if (number === 1) return ['This is the house that Jack built.'];
    const lastIndex = number - 2;
    const lines = [`This is the ${chain[lastIndex].subject}`];
    for (let index = lastIndex; index >= 0; index -= 1) lines.push(chain[index].action);
    return lines;
  }

  static verses(start, end) {
    const result = [];
    for (let number = start; number <= end; number += 1) {
      if (result.length > 0) result.push('');
      result.push(...House.verse(number));
    }
    return result;
  }
}
