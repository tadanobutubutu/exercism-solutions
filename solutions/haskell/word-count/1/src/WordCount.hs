module WordCount (wordCount) where

import Data.Char (toLower)
import Data.List (group, sort)

wordCount :: String -> [(String, Int)]
wordCount = countWords . tokenize
  where
    countWords = map (\wordGroup -> (head wordGroup, length wordGroup)) . group . sort

    tokenize = go []

    go current []
      | null current = []
      | otherwise = [reverse current]
    go current (char : rest)
      | isAsciiAlphaNum char = go (toLower char : current) rest
      | char == '\'' && not (null current) && beginsWithAlphaNum rest =
          go (char : current) rest
      | null current = go [] rest
      | otherwise = reverse current : go [] rest

    beginsWithAlphaNum (char : _) = isAsciiAlphaNum char
    beginsWithAlphaNum [] = False

    isAsciiAlphaNum char =
      (char >= 'a' && char <= 'z')
        || (char >= 'A' && char <= 'Z')
        || (char >= '0' && char <= '9')
