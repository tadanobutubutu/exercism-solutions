module Bob (responseFor) where

import Data.Char (isAlpha, isSpace, isUpper)
import Data.List (dropWhileEnd)

responseFor :: String -> String
responseFor xs
  | null trimmed = "Fine. Be that way!"
  | yelling && question = "Calm down, I know what I'm doing!"
  | yelling = "Whoa, chill out!"
  | question = "Sure."
  | otherwise = "Whatever."
  where
    trimmed = dropWhileEnd isSpace xs
    letters = filter isAlpha trimmed
    yelling = not (null letters) && all isUpper letters
    question = not (null trimmed) && last trimmed == '?'
