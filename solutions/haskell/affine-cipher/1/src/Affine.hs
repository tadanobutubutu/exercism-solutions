module Affine (decode, encode) where

import Data.Char (chr, ord)

decode :: (Int, Int) -> String -> Maybe String
decode (a, b) cipherText = do
  inverse <- modularInverse a
  pure . concatMap (decodeChar inverse b) . filter isCipherChar $ cipherText

encode :: (Int, Int) -> String -> Maybe String
encode (a, b) plainText = do
  _ <- modularInverse a
  let encoded = concatMap (encodeChar a b) (filter isCipherChar plainText)
  pure (unwords (groupsOfFive encoded))

modularInverse :: Int -> Maybe Int
modularInverse a
  | gcd (a `mod` 26) 26 /= 1 = Nothing
  | otherwise = findInverse 0
  where
    reduced = a `mod` 26
    findInverse candidate
      | candidate >= 26 = Nothing
      | (reduced * candidate) `mod` 26 == 1 = Just candidate
      | otherwise = findInverse (candidate + 1)

isCipherChar :: Char -> Bool
isCipherChar c = isAsciiLetter c || (c >= '0' && c <= '9')

isAsciiLetter :: Char -> Bool
isAsciiLetter c = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')

encodeChar :: Int -> Int -> Char -> String
encodeChar a b c
  | c >= '0' && c <= '9' = [c]
  | otherwise =
      let value = ord (toLowerAscii c) - ord 'a'
      in [chr (ord 'a' + (a * value + b) `mod` 26)]

decodeChar :: Int -> Int -> Char -> String
decodeChar _ _ c | c >= '0' && c <= '9' = [c]
decodeChar inverse b c =
  let value = ord (toLowerAscii c) - ord 'a'
  in [chr (ord 'a' + (inverse * (value - b)) `mod` 26)]

toLowerAscii :: Char -> Char
toLowerAscii c
  | c >= 'A' && c <= 'Z' = chr (ord c + ord 'a' - ord 'A')
  | otherwise = c

groupsOfFive :: String -> [String]
groupsOfFive [] = []
groupsOfFive chars = take 5 chars : groupsOfFive (drop 5 chars)
