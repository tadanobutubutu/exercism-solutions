export function format(name: string, number: number): string {
  const lastTwoDigits = number % 100
  let suffix = 'th'

  if (lastTwoDigits < 11 || lastTwoDigits > 13) {
    switch (number % 10) {
      case 1:
        suffix = 'st'
        break
      case 2:
        suffix = 'nd'
        break
      case 3:
        suffix = 'rd'
        break
    }
  }

  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`
}
