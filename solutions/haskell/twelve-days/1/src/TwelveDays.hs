module TwelveDays (recite) where

import Data.List (intercalate)

recite :: Int -> Int -> [String]
recite start stop = map verse [max 1 start .. min 12 stop]
  where
    verse day =
      "On the " ++ ordinalWords !! (day - 1)
        ++ " day of Christmas my true love gave to me: "
        ++ giftList day ++ "."

    giftList day = case reverse (take day gifts) of
      [lastGift] -> lastGift
      descendingGifts ->
        intercalate ", " (init descendingGifts) ++ ", and " ++ last descendingGifts

ordinalWords :: [String]
ordinalWords =
  [ "first", "second", "third", "fourth", "fifth", "sixth"
  , "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  ]

gifts :: [String]
gifts =
  [ "a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens"
  , "four Calling Birds", "five Gold Rings", "six Geese-a-Laying"
  , "seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing"
  , "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"
  ]
