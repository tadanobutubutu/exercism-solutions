module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify number
  | number <= 0 = Nothing
  | divisorSum == number = Just Perfect
  | divisorSum < number = Just Deficient
  | otherwise = Just Abundant
  where
    divisorSum = (if number > 1 then 1 else 0)
      + sum (concatMap properFactors [2 .. floor (sqrt (fromIntegral number :: Double))])
    properFactors divisor
      | number `mod` divisor /= 0 = []
      | pairedDivisor == divisor = [divisor]
      | pairedDivisor == number = [divisor]
      | otherwise = [divisor, pairedDivisor]
      where
        pairedDivisor = number `div` divisor
