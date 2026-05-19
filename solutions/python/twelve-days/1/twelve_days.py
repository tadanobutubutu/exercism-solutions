def recite(start_verse, end_verse):
    days = [
        ("first", "a Partridge in a Pear Tree."),
        ("second", "two Turtle Doves, "),
        ("third", "three French Hens, "),
        ("fourth", "four Calling Birds, "),
        ("fifth", "five Gold Rings, "),
        ("sixth", "six Geese-a-Laying, "),
        ("seventh", "seven Swans-a-Swimming, "),
        ("eighth", "eight Maids-a-Milking, "),
        ("ninth", "nine Ladies Dancing, "),
        ("tenth", "ten Lords-a-Leaping, "),
        ("eleventh", "eleven Pipers Piping, "),
        ("twelfth", "twelve Drummers Drumming, ")
    ]

    def get_verse(n):
        day_str, _ = days[n-1]
        verse = f"On the {day_str} day of Christmas my true love gave to me: "
        
        gift_list = []
        for i in range(n-1, -1, -1):
            _, gift = days[i]
            if n > 1 and i == 0:
                gift = "and " + gift
            gift_list.append(gift)
            
        return verse + "".join(gift_list)

    return [get_verse(n) for n in range(start_verse, end_verse + 1)]
