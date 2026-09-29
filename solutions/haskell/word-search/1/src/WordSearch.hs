module WordSearch (search, CharPos(..), WordPos(..)) where

data CharPos = CharPos{col::Int, row::Int} deriving (Eq, Show)
data WordPos = WordPos{start::CharPos, end::CharPos} deriving (Eq, Show)

search :: [String] -> [String] -> [(String, Maybe WordPos)]
search grid wordList = [(word, locate word) | word <- wordList]
  where
    height = length grid
    directions =
      [ (0, 1), (1, 0), (1, 1), (1, -1)
      , (0, -1), (-1, 0), (-1, -1), (-1, 1)
      ]

    locate "" = Nothing
    locate word = findLocation candidates
      where
        candidates =
          [ WordPos
              (CharPos (colIndex + 1) (rowIndex + 1))
              (CharPos (endCol + 1) (endRow + 1))
          | rowIndex <- [0 .. height - 1]
          , colIndex <- [0 .. rowWidth rowIndex - 1]
          , (rowStep, colStep) <- directions
          , let endRow = rowIndex + (length word - 1) * rowStep
          , let endCol = colIndex + (length word - 1) * colStep
          , all (matchesCharacter word rowIndex colIndex rowStep colStep) [0 .. length word - 1]
          ]

    findLocation [] = Nothing
    findLocation (position : _) = Just position

    rowWidth rowIndex = length (grid !! rowIndex)

    matchesCharacter word rowIndex colIndex rowStep colStep offset =
      let currentRow = rowIndex + offset * rowStep
          currentCol = colIndex + offset * colStep
      in currentRow >= 0
          && currentRow < height
          && currentCol >= 0
          && currentCol < rowWidth currentRow
          && grid !! currentRow !! currentCol == word !! offset
