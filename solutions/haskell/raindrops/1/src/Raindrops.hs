module Raindrops (convert) where

convert :: Int -> String
convert n =
  let sounds =
        [ word
        | (factor, word) <- [(3, "Pling"), (5, "Plang"), (7, "Plong")]
        , n `mod` factor == 0
        ]
  in if null sounds then show n else concat sounds
