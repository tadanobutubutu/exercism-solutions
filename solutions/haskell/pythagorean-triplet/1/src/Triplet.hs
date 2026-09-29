module Triplet (tripletsWithSum) where

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum total =
  [ (a, b, c)
  | a <- [1 .. total `div` 3]
  , let numerator = total * (total - 2 * a)
        denominator = 2 * (total - a)
  , denominator /= 0
  , numerator `mod` denominator == 0
  , let b = numerator `div` denominator
        c = total - a - b
  , a < b
  , b < c
  , a * a + b * b == c * c
  ]
