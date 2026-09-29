module RotationalCipher (rotate) where

import Data.Char (chr, ord)

rotate :: Int -> String -> String
rotate number = map rotateChar
  where
    shift = number `mod` 26
    rotateChar c
      | c >= 'a' && c <= 'z' = chr (ord 'a' + (ord c - ord 'a' + shift) `mod` 26)
      | c >= 'A' && c <= 'Z' = chr (ord 'A' + (ord c - ord 'A' + shift) `mod` 26)
      | otherwise = c
