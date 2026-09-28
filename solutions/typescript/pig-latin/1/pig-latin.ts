const vowels = new Set(['a', 'e', 'i', 'o', 'u'])

const translateWord = (word: string): string => {
  if (vowels.has(word[0] ?? '') || word.startsWith('xr') || word.startsWith('yt')) {
    return `${word}ay`
  }

  let split = word.startsWith('qu') ? 2 : 1
  while (split < word.length) {
    if (word[split] === 'q' && word[split + 1] === 'u') {
      split += 2
      continue
    }
    if (vowels.has(word[split] ?? '') || word[split] === 'y') break
    split++
  }
  return `${word.slice(split)}${word.slice(0, split)}ay`
}

export function translate(phrase: string): string {
  return phrase.split(' ').map(translateWord).join(' ')
}
