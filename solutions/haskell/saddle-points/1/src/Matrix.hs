module Matrix (saddlePoints) where

import Data.Array (Array, bounds, (!))

saddlePoints :: Ord e => Array (Int, Int) e -> [(Int, Int)]
saddlePoints matrix =
  [ (row, col)
  | row <- [minRow .. maxRow]
  , col <- [minCol .. maxCol]
  , let value = matrix ! (row, col)
  , value == maximum [matrix ! (row, otherCol) | otherCol <- [minCol .. maxCol]]
  , value == minimum [matrix ! (otherRow, col) | otherRow <- [minRow .. maxRow]]
  ]
  where
    ((minRow, minCol), (maxRow, maxCol)) = bounds matrix
