module Counting (
    Color(..),
    territories,
    territoryFor
) where

import Data.Set (Set)
import qualified Data.Set as Set

data Color = Black | White deriving (Eq, Ord, Show)
type Coord = (Int, Int)

territories :: [String] -> [(Set Coord, Maybe Color)]
territories board =
  [(region, ownerOf board region) | region <- emptyRegions board]

territoryFor :: [String] -> Coord -> Maybe (Set Coord, Maybe Color)
territoryFor board coord
  | not (inside board coord) = Nothing
  | cellAt board coord /= ' ' = Nothing
  | otherwise = case filter (Set.member coord) (emptyRegions board) of
      region : _ -> Just (region, ownerOf board region)
      [] -> Nothing

emptyRegions :: [String] -> [Set Coord]
emptyRegions board = collect emptyCoordinates Set.empty
  where
    emptyCoordinates =
      [ (x, y)
      | (y, line) <- zip [1 ..] board
      , x <- [1 .. length line]
      , line !! (x - 1) == ' '
      ]

    collect [] _ = []
    collect (coord : remaining) visited
      | Set.member coord visited = collect remaining visited
      | otherwise =
          let region = flood [coord] Set.empty
          in region : collect remaining (Set.union visited region)

    flood [] visited = visited
    flood (coord : queue) visited
      | Set.member coord visited = flood queue visited
      | not (inside board coord) || cellAt board coord /= ' ' =
          flood queue visited
      | otherwise =
          flood (neighbors coord ++ queue) (Set.insert coord visited)

ownerOf :: [String] -> Set Coord -> Maybe Color
ownerOf board region = case adjacentColors of
  colors | Set.size colors == 1 -> Set.lookupMin colors
  _ -> Nothing
  where
    adjacentColors = Set.fromList
      [ color
      | coord <- Set.toList region
      , neighbor <- neighbors coord
      , inside board neighbor
      , Just color <- [colorAt (cellAt board neighbor)]
      ]

colorAt :: Char -> Maybe Color
colorAt 'B' = Just Black
colorAt 'W' = Just White
colorAt _ = Nothing

neighbors :: Coord -> [Coord]
neighbors (x, y) = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]

inside :: [String] -> Coord -> Bool
inside board (x, y) =
  y >= 1 && y <= length board
    && x >= 1
    && x <= length (board !! (y - 1))

cellAt :: [String] -> Coord -> Char
cellAt board (x, y) = board !! (y - 1) !! (x - 1)
