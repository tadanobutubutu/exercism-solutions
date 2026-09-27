USING: kernel math ranges sequences strings ;
IN: twelve-days

CONSTANT: ordinals {
    "first" "second" "third" "fourth" "fifth" "sixth"
    "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth"
}

CONSTANT: gifts {
    "a Partridge in a Pear Tree"
    "two Turtle Doves"
    "three French Hens"
    "four Calling Birds"
    "five Gold Rings"
    "six Geese-a-Laying"
    "seven Swans-a-Swimming"
    "eight Maids-a-Milking"
    "nine Ladies Dancing"
    "ten Lords-a-Leaping"
    "eleven Pipers Piping"
    "twelve Drummers Drumming"
}

:: verse ( day -- line )
    "On the " day 1 - ordinals nth append
    " day of Christmas my true love gave to me: " append
    day 1 [a..b] [| gift-day |
        gift-day 1 - gifts nth
    ] map :> items
    items length 1 = [ items first ] [
        items but-last ", " join ", and " append items last append
    ] if append
    "." append ;

:: recite ( start end -- lines )
    start end [a..b] [ verse ] map ;
