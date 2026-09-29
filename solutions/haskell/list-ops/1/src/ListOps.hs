module ListOps
  ( length
  , reverse
  , map
  , filter
  , foldr
  , foldl'
  , (++)
  , concat
  ) where

import Prelude hiding
  ( length, reverse, map, filter, foldr, (++), concat )

infixr 5 ++

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' f = go
  where
    go acc [] = acc
    go acc (x : xs) =
      let next = f acc x
      in next `seq` go next xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z [] = z
foldr f z (x : xs) = f x (foldr f z xs)

length :: [a] -> Int
length = foldl' (\n _ -> n + 1) 0

reverse :: [a] -> [a]
reverse = foldl' (flip (:)) []

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x : xs) = f x : map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x : xs)
  | p x = x : filter p xs
  | otherwise = filter p xs

(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x : xs) ++ ys = x : (xs ++ ys)

concat :: [[a]] -> [a]
concat = foldr (++) []
