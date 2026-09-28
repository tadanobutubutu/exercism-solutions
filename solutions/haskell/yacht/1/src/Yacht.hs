module Yacht (yacht, Category(..)) where

import Data.List (sort)

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht category dice = case category of
  Ones -> scoreFor 1
  Twos -> scoreFor 2
  Threes -> scoreFor 3
  Fours -> scoreFor 4
  Fives -> scoreFor 5
  Sixes -> scoreFor 6
  FullHouse -> if sort (map snd frequencies) == [2, 3] then sum dice else 0
  FourOfAKind -> sum [face * 4 | (face, count) <- frequencies, count >= 4]
  LittleStraight -> if sort dice == [1, 2, 3, 4, 5] then 30 else 0
  BigStraight -> if sort dice == [2, 3, 4, 5, 6] then 30 else 0
  Choice -> sum dice
  Yacht -> if any ((== 5) . snd) frequencies then 50 else 0
  where
    scoreFor face = face * length (filter (== face) dice)
    frequencies =
      [ (face, length (filter (== face) dice))
      | face <- [1 .. 6]
      , face `elem` dice
      ]
