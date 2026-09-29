module Frequency (frequency) where

import Data.Map  (Map)
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Char (isLetter, toLower)

frequency :: Int -> [Text] -> Map Char Int
frequency _ texts =
  Map.fromListWith (+)
    [ (toLower character, 1)
    | text <- texts
    , character <- Text.unpack text
    , isLetter character
    ]
