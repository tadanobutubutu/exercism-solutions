module SumOfMultiples (sumOfMultiples) where

import qualified Data.Set as Set

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = Set.foldl' (+) 0 multiples
  where
    multiples = Set.fromList
      [ multiple
      | factor <- factors
      , factor /= 0
      , multiple <- [abs factor, 2 * abs factor .. limit - 1]
      ]
