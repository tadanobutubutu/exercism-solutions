module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.List (sort)

anagramsFor :: String -> [String] -> [String]
anagramsFor subject candidates = filter isAnagram candidates
  where
    normalizedSubject = map toLower subject
    sortedSubject = sort normalizedSubject

    isAnagram candidate =
      let normalizedCandidate = map toLower candidate
      in normalizedCandidate /= normalizedSubject
          && sort normalizedCandidate == sortedSubject
