const ANIMALS = [
  { name: 'fly', line: null },
  { name: 'spider', line: 'It wriggled and jiggled and tickled inside her.', desc: 'that wriggled and jiggled and tickled inside her' },
  { name: 'bird', line: 'How absurd to swallow a bird!' },
  { name: 'cat', line: 'Imagine that, to swallow a cat!' },
  { name: 'dog', line: 'What a hog, to swallow a dog!' },
  { name: 'goat', line: 'Just opened her throat and swallowed a goat!' },
  { name: 'cow', line: "I don't know how she swallowed a cow!" },
  { name: 'horse', line: "She's dead, of course!", end: true },
];

export class Song {
  verse(n) {
    const animal = ANIMALS[n - 1];
    const lines = [`I know an old lady who swallowed a ${animal.name}.`];
    if (animal.line) lines.push(animal.line);
    if (animal.end) return lines.join('\n') + '\n';
    for (let i = n - 1; i > 0; i--) {
      const prey = ANIMALS[i];
      const predator = ANIMALS[i - 1];
      const desc = predator.desc ? ` ${predator.desc}` : '';
      lines.push(`She swallowed the ${prey.name} to catch the ${predator.name}${desc}.`);
    }
    lines.push("I don't know why she swallowed the fly. Perhaps she'll die.");
    return lines.join('\n') + '\n';
  }

  verses(start, end) {
    const result = [];
    for (let i = start; i <= end; i++) {
      result.push(this.verse(i));
    }
    return result.join('\n') + '\n';
  }
}
