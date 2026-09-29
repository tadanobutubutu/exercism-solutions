module Transpose (transpose) where

transpose :: [String] -> [String]
transpose rows =
  [ columnAt columnIndex
  | columnIndex <- [0 .. longestRow - 1]
  ]
  where
    longestRow = maximum (0 : map length rows)
    columnAt columnIndex =
      let cells = map (at columnIndex) rows
          lastRow = lastPresent cells
      in [maybe ' ' id cell | cell <- take (lastRow + 1) cells]
    at index row
      | index < length row = Just (row !! index)
      | otherwise = Nothing
    lastPresent cells =
      maximum (-1 : [index | (index, Just _) <- zip [0 ..] cells])
