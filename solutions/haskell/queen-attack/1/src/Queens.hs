module Queens (boardString, canAttack) where

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines
  [ unwords [[cell row col] | col <- [0 .. 7]]
  | row <- [0 .. 7]
  ]
  where
    cell row col
      | white == Just (row, col) = 'W'
      | black == Just (row, col) = 'B'
      | otherwise = '_'

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (rowA, colA) (rowB, colB) =
  rowA == rowB
    || colA == colB
    || abs (rowA - rowB) == abs (colA - colB)
