const ones = [
  'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
]
const teens = [
  'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
  'seventeen', 'eighteen', 'nineteen',
]
const tens = [
  '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
]

const underThousand = (number: number): string => {
  const parts: string[] = []
  if (number >= 100) {
    parts.push(`${ones[Math.floor(number / 100)]} hundred`)
    number %= 100
  }
  if (number >= 20) {
    const ten = tens[Math.floor(number / 10)]!
    const one = number % 10
    parts.push(one === 0 ? ten : `${ten}-${ones[one]}`)
  } else if (number >= 10) {
    parts.push(teens[number - 10]!)
  } else if (number > 0) {
    parts.push(ones[number]!)
  }
  return parts.join(' ')
}

export function sayInEnglish(number: number): string {
  if (!Number.isInteger(number) || number < 0 || number > 999_999_999_999) {
    throw new Error('Number must be between 0 and 999,999,999,999.')
  }
  if (number === 0) return 'zero'

  const scales = [
    [1_000_000_000, 'billion'],
    [1_000_000, 'million'],
    [1_000, 'thousand'],
    [1, ''],
  ] as const
  const parts: string[] = []
  let remaining = number
  for (const [scale, label] of scales) {
    const group = Math.floor(remaining / scale)
    if (group > 0) {
      const words = underThousand(group)
      parts.push(label ? `${words} ${label}` : words)
      remaining %= scale
    }
  }
  return parts.join(' ')
}
