module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text = all (`elem` lowercase) ['a' .. 'z']
  where
    lowercase = map toLower text
