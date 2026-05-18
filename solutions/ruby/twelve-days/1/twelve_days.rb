class TwelveDays
  DAYS = [
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  ]

  GIFTS = [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  def self.song
    (1..12).map { |n| verse(n) }.join("\n\n") + "\n"
  end

  def self.verse(n)
    "On the #{DAYS[n-1]} day of Christmas my true love gave to me: #{gifts_list(n)}."
  end

  def self.gifts_list(n)
    return GIFTS[0] if n == 1
    list = GIFTS[1...n].reverse
    list.join(", ") + ", and " + GIFTS[0]
  end
end
