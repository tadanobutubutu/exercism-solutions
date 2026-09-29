module Connect (Mark(..), winner) where

data Mark = Cross | Nought deriving (Eq, Show)

winner :: [String] -> Maybe Mark
winner board
  | hasConnection Cross = Just Cross
  | hasConnection Nought = Just Nought
  | otherwise = Nothing
  where
    cells = map words board
    rowCount = length cells
    columnCount = maximum (0 : map length cells)
    hasConnection mark = search starts []
      where
        starts =
          case mark of
            Cross -> [(row, 0) | row <- [0 .. rowCount - 1], cellAt row 0 == markChar mark]
            Nought -> [(0, column) | column <- [0 .. columnCount - 1], cellAt 0 column == markChar mark]
        search [] _ = False
        search ((row, column) : queue) visited
          | (row, column) `elem` visited = search queue visited
          | cellAt row column /= markChar mark = search queue ((row, column) : visited)
          | isGoal mark row column = True
          | otherwise = search (queue ++ adjacent row column) ((row, column) : visited)
    adjacent row column =
      [ (nextRow, nextColumn)
      | (nextRow, nextColumn) <-
          [ (row - 1, column)
          , (row - 1, column + 1)
          , (row, column - 1)
          , (row, column + 1)
          , (row + 1, column - 1)
          , (row + 1, column)
          ]
      , nextRow >= 0
      , nextRow < rowCount
      , nextColumn >= 0
      , nextColumn < columnCount
      , cellAt nextRow nextColumn == cellAt row column
      ]
    cellAt row column
      | row < 0 || row >= rowCount = '.'
      | column < 0 || column >= length (cells !! row) = '.'
      | otherwise = case cells !! row !! column of
          [cell] -> cell
          _ -> '.'
    isGoal Cross _ column = column == columnCount - 1
    isGoal Nought row _ = row == rowCount - 1

markChar :: Mark -> Char
markChar Cross = 'X'
markChar Nought = 'O'
