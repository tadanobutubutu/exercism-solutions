module Luhn (isValid) where

import Data.Char (digitToInt)

isValid :: String -> Bool
isValid input =
  length digits > 1
    && all isAsciiDigit digits
    && sum (map luhnValue (zip [0 :: Int ..] (reverse digits))) `mod` 10 == 0
  where
    digits = filter (/= ' ') input
    isAsciiDigit c = c >= '0' && c <= '9'
    luhnValue (index, c)
      | even index = digitToInt c
      | doubled > 9 = doubled - 9
      | otherwise = doubled
      where
        doubled = 2 * digitToInt c
