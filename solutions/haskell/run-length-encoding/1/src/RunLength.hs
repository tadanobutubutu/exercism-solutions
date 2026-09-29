module RunLength (decode, encode) where

import Data.Char (ord)
import Data.List (group)

decode :: String -> String
decode = go 0
  where
    go _ [] = []
    go count (char : rest)
      | char >= '0' && char <= '9' =
          go (count * 10 + ord char - ord '0') rest
      | otherwise = replicate (if count == 0 then 1 else count) char ++ go 0 rest

encode :: String -> String
encode = concatMap encodeGroup . group
  where
    encodeGroup [] = ""
    encodeGroup chars@(char : _)
      | length chars == 1 = [char]
      | otherwise = show (length chars) ++ [char]
