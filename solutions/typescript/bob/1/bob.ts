export function hey(message: string): string {
  const trimmed = message.trim()
  if (trimmed.length === 0) return 'Fine. Be that way!'

  const isQuestion = trimmed.endsWith('?')
  const hasLetters = /[a-z]/i.test(trimmed)
  const isShouting = hasLetters && trimmed === trimmed.toUpperCase()

  if (isShouting && isQuestion) return "Calm down, I know what I'm doing!"
  if (isShouting) return 'Whoa, chill out!'
  if (isQuestion) return 'Sure.'
  return 'Whatever.'
}
