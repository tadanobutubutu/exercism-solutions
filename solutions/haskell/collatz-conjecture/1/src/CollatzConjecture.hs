module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0 = Nothing
  | otherwise = Just (stepsToOne n 0)
  where
    stepsToOne 1 steps = steps
    stepsToOne current steps
      | even current = stepsToOne (current `div` 2) (steps + 1)
      | otherwise = stepsToOne (3 * current + 1) (steps + 1)
