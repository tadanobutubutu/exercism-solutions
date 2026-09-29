module Change (findFewestCoins) where

import Data.List (minimumBy)
import Data.Ord (comparing)

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins target coins
  | target < 0 = Nothing
  | otherwise = table !! fromInteger target
  where
    table = Just [] : [bestFor amount | amount <- [1 .. target]]

    bestFor amount = case candidates of
      [] -> Nothing
      _ -> Just (minimumBy (comparing length) candidates)
      where
        candidates =
          [ usedCoins ++ [coin]
          | coin <- coins
          , coin > 0
          , coin <= amount
          , Just usedCoins <- [table !! fromInteger (amount - coin)]
          ]
