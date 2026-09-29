module Knapsack (maximumValue) where

maximumValue :: Int -> [(Int, Int)] -> Int
maximumValue capacity items
  | capacity < 0 = 0
  | otherwise = foldl addItem (replicate (capacity + 1) 0) items !! capacity
  where
    addItem previous (weight, value)
      | weight < 0 = previous
      | otherwise =
          [ max (previous !! limit)
              (if weight <= limit then value + previous !! (limit - weight) else 0)
          | limit <- [0 .. capacity]
          ]
