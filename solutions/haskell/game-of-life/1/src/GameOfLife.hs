module GameOfLife (tick) where

tick :: [[Int]] -> [[Int]]
tick [] = []
tick board@(firstRow : _) =
  [ [nextCell row col | col <- [0 .. width - 1]]
  | row <- [0 .. height - 1]
  ]
  where
    height = length board
    width = length firstRow

    nextCell row col
      | alive == 1 && neighbors `elem` [2, 3] = 1
      | alive == 0 && neighbors == 3 = 1
      | otherwise = 0
      where
        alive = board !! row !! col
        neighbors = sum
          [ board !! neighborRow !! neighborCol
          | neighborRow <- [row - 1 .. row + 1]
          , neighborCol <- [col - 1 .. col + 1]
          , (neighborRow, neighborCol) /= (row, col)
          , neighborRow >= 0
          , neighborRow < height
          , neighborCol >= 0
          , neighborCol < width
          ]
