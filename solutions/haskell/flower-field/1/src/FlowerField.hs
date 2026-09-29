module FlowerField (annotate) where

import Data.Char (intToDigit)

annotate :: [String] -> [String]
annotate board =
  [ [ if cell == '*' then '*' else mark (flowerCount row column)
    | (column, cell) <- zip [0 ..] cells
    ]
  | (row, cells) <- zip [0 ..] board
  ]
  where
    flowerCount row column =
      length
        [ ()
        | rowOffset <- [-1 .. 1]
        , columnOffset <- [-1 .. 1]
        , rowOffset /= 0 || columnOffset /= 0
        , isFlowerAt (row + rowOffset) (column + columnOffset)
        ]

    isFlowerAt row column
      | row < 0 || column < 0 = False
      | otherwise = case drop row board of
          cells : _ -> case drop column cells of
            cell : _ -> cell == '*'
            [] -> False
          [] -> False

    mark 0 = ' '
    mark count = intToDigit count
