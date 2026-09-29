module StateOfTicTacToe (gameState, GameState(..)) where

data GameState = WinX | WinO | Draw | Ongoing | Impossible deriving (Eq, Show)

gameState :: [String] -> GameState
gameState board
  | not (validBoard board) = Impossible
  | not (xCount == oCount || xCount == oCount + 1) = Impossible
  | xWins && oWins = Impossible
  | xWins = if xCount == oCount + 1 && canBeLastMove 'X' then WinX else Impossible
  | oWins = if xCount == oCount && canBeLastMove 'O' then WinO else Impossible
  | xCount + oCount == 9 = Draw
  | otherwise = Ongoing
  where
    cells = concat board
    xCount = count 'X' cells
    oCount = count 'O' cells
    xWins = hasWon 'X' board
    oWins = hasWon 'O' board

    canBeLastMove mark = any removesTheWin positions
      where
        positions = [(row, col) | row <- [0 .. 2], col <- [0 .. 2]]
        removesTheWin (row, col)
          | board !! row !! col /= mark = False
          | otherwise =
              let previous =
                    [ if rowIndex == row then replaceAt col ' ' line else line
                    | (rowIndex, line) <- zip [0 ..] board
                    ]
              in not (hasWon 'X' previous || hasWon 'O' previous)

validBoard :: [String] -> Bool
validBoard board =
  length board == 3
    && all ((== 3) . length) board
    && all (`elem` "XO ") (concat board)

count :: Char -> String -> Int
count target = length . filter (== target)

hasWon :: Char -> [String] -> Bool
hasWon mark board = any (all (== mark)) winningLines
  where
    rows = board
    columns = [[board !! row !! col | row <- [0 .. 2]] | col <- [0 .. 2]]
    diagonals =
      [ [board !! index !! index | index <- [0 .. 2]]
      , [board !! index !! (2 - index) | index <- [0 .. 2]]
      ]
    winningLines = rows ++ columns ++ diagonals

replaceAt :: Int -> a -> [a] -> [a]
replaceAt index value values = take index values ++ value : drop (index + 1) values
