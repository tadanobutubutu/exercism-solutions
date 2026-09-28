module Acronym (abbreviate) where

import Data.Char (isAlpha, isLower, isSpace, isUpper, toUpper)

abbreviate :: String -> String
abbreviate phrase =
  [ toUpper current
  | (previous, current) <- zip (Nothing : map Just normalized) normalized
  , isAlpha current
  , maybe True (\character -> isSpace character || (isUpper current && isLower character)) previous
  ]
  where
    normalized = map replaceHyphen . filter allowed $ phrase
    allowed character = isAlpha character || isSpace character || character == '-'
    replaceHyphen '-' = ' '
    replaceHyphen character = character
