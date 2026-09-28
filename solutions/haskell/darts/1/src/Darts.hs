module Darts (score) where

score :: Float -> Float -> Int
score x y
  | distanceSquared <= 1 = 10
  | distanceSquared <= 25 = 5
  | distanceSquared <= 100 = 1
  | otherwise = 0
  where
    distanceSquared = x * x + y * y
