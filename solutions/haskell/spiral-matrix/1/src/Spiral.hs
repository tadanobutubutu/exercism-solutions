module Spiral (spiral) where

spiral :: Int -> [[Int]]
spiral size
  | size <= 0 = []
  | otherwise =
      [ [valueAt row col | col <- [0 .. size - 1]]
      | row <- [0 .. size - 1]
      ]
  where
    valueAt row col =
      let layer = minimum [row, col, size - 1 - row, size - 1 - col]
          side = size - 2 * layer
          lastIndex = size - layer - 1
          offset
            | side == 1 = 0
            | row == layer = col - layer
            | col == lastIndex = side + row - layer - 1
            | row == lastIndex = 2 * side - 2 + lastIndex - col
            | otherwise = 3 * side - 3 + lastIndex - row
      in size * size - side * side + offset + 1
