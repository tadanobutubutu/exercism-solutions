module Sieve (primesUpTo) where

-- You should not use any of the division operations when implementing
-- the sieve of Eratosthenes.
import Prelude hiding (div, mod, divMod, rem, quotRem, quot, (/))

primesUpTo :: Integer -> [Integer]
primesUpTo n = sieve [2 .. n]
  where
    sieve [] = []
    sieve (prime : candidates) =
      prime : sieve (removeMultiples prime candidates)

    removeMultiples prime = merge [prime * prime, prime * prime + prime ..]

    merge _ [] = []
    merge [] _ = []
    merge multiples@(multiple : restMultiples) values@(value : restValues)
      | value < multiple = value : merge multiples restValues
      | value == multiple = merge restMultiples restValues
      | otherwise = merge restMultiples values
