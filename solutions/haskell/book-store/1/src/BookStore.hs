module BookStore (total, Book(..)) where

import Data.List (foldl', subsequences)
import qualified Data.Map.Strict as Map

data Book = First | Second | Third | Fourth | Fifth

total :: [Book] -> Int
total basket = bestPrice counts
  where
    counts =
      [ length (filter ((== bookNumber) . bookIndex) basket)
      | bookNumber <- [0 .. 4]
      ]

bestPrice :: [Int] -> Int
bestPrice = fst . solve Map.empty

solve :: Map.Map [Int] Int -> [Int] -> (Int, Map.Map [Int] Int)
solve cache counts =
  case Map.lookup counts cache of
    Just answer -> (answer, cache)
    Nothing
      | all (== 0) counts -> (0, Map.insert counts 0 cache)
      | otherwise ->
          let available = [index | (index, count) <- zip ([0 ..] :: [Int]) counts, count > 0]
              groups = filter (not . null) (subsequences available)
              (answer, updatedCache) = foldl' consider (maxBound, cache) groups
          in (answer, Map.insert counts answer updatedCache)
  where
    consider (best, currentCache) group =
      let nextCounts =
            [ count - if index `elem` group then 1 else 0
            | (index, count) <- zip ([0 ..] :: [Int]) counts
            ]
          (remainingPrice, nextCache) = solve currentCache nextCounts
          candidate = groupPrice (length group) + remainingPrice
      in (min best candidate, nextCache)

groupPrice :: Int -> Int
groupPrice size = case size of
  1 -> 800
  2 -> 1520
  3 -> 2160
  4 -> 2560
  5 -> 3000
  _ -> 0

bookIndex :: Book -> Int
bookIndex First = 0
bookIndex Second = 1
bookIndex Third = 2
bookIndex Fourth = 3
bookIndex Fifth = 4
