const ordinals = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
  'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth',
]

const gifts = [
  'a Partridge in a Pear Tree',
  'two Turtle Doves',
  'three French Hens',
  'four Calling Birds',
  'five Gold Rings',
  'six Geese-a-Laying',
  'seven Swans-a-Swimming',
  'eight Maids-a-Milking',
  'nine Ladies Dancing',
  'ten Lords-a-Leaping',
  'eleven Pipers Piping',
  'twelve Drummers Drumming',
]

export function recite(start: number, end: number): string {
  let lyrics = ''
  for (let day = start; day <= end; day++) {
    let presents: string
    if (day === 1) {
      presents = gifts[0]!
    } else {
      const items: string[] = []
      for (let gift = day - 1; gift >= 1; gift--) items.push(gifts[gift]!)
      presents = `${items.join(', ')}, and ${gifts[0]}`
    }
    lyrics += `On the ${ordinals[day - 1]} day of Christmas my true love gave to me: ${presents}.\n`
  }
  return lyrics
}
