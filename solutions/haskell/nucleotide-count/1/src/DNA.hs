module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (foldl')

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs
  | any (`notElem` "ACGT") xs = Left "invalid nucleotide"
  | otherwise = Right (foldl' count initial xs)
  where
    initial = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
    count counts nucleotide = Map.insertWith (+) (toNucleotide nucleotide) 1 counts
    toNucleotide nucleotide = case nucleotide of
      'A' -> A
      'C' -> C
      'G' -> G
      'T' -> T
      _   -> A
