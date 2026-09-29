module Matrix
    ( Matrix
    , cols
    , column
    , flatten
    , fromList
    , fromString
    , reshape
    , row
    , rows
    , shape
    , transpose
    ) where

import Data.Vector (Vector)
import qualified Data.Vector as Vector

data Matrix a = Matrix
  { matrixShape :: (Int, Int)
  , matrixValues :: Vector a
  } deriving (Eq, Show)

cols :: Matrix a -> Int
cols = snd . matrixShape

column :: Int -> Matrix a -> Vector a
column index (Matrix (rowCount, columnCount) values) =
  Vector.generate rowCount (\rowIndex -> values Vector.! (rowIndex * columnCount + index - 1))

flatten :: Matrix a -> Vector a
flatten = matrixValues

fromList :: [[a]] -> Matrix a
fromList xss =
  let rowCount = length xss
      columnCount = case xss of
        [] -> 0
        firstRow : _ -> length firstRow
  in Matrix (rowCount, columnCount) (Vector.fromList (concat xss))

fromString :: Read a => String -> Matrix a
fromString input = fromList parsed
  where
    parsed =
      [ map read numbers
      | line <- lines input
      , let numbers = words line
      , not (Prelude.null numbers)
      ]

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape dimensions@(rowCount, columnCount) matrix
  | rowCount < 0 || columnCount < 0 = error "reshape: negative dimension"
  | rowCount * columnCount /= Vector.length (flatten matrix) = error "reshape: element count mismatch"
  | otherwise = Matrix dimensions (flatten matrix)

row :: Int -> Matrix a -> Vector a
row index (Matrix (_, columnCount) values) =
  Vector.slice ((index - 1) * columnCount) columnCount values

rows :: Matrix a -> Int
rows = fst . matrixShape

shape :: Matrix a -> (Int, Int)
shape = matrixShape

transpose :: Matrix a -> Matrix a
transpose (Matrix (rowCount, columnCount) values) =
  Matrix (columnCount, rowCount) $ Vector.generate (rowCount * columnCount) $ \index ->
    let newRow = index `div` rowCount
        newColumn = index `mod` rowCount
    in values Vector.! (newColumn * columnCount + newRow)
