module CryptoSquare (encode) where

import Data.Char (isAlphaNum, toLower)
import Data.List (intercalate)

encode :: String -> String
encode input
  | null normalized = ""
  | otherwise = intercalate " " columnsText
  where
    normalized = filter isAlphaNum (map toLower input)
    messageLength = length normalized
    (rows, columns) = findDimensions 1
    findDimensions c
      | c > 1 && (c - 1) * c >= messageLength = (c - 1, c)
      | c * c >= messageLength = (c, c)
      | otherwise = findDimensions (c + 1)
    characterAt index
      | index < messageLength = normalized !! index
      | otherwise = ' '
    columnsText =
      [ [characterAt (row * columns + column) | row <- [0 .. rows - 1]]
      | column <- [0 .. columns - 1]
      ]
