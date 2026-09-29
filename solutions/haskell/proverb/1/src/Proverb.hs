module Proverb(recite) where

recite :: [String] -> String
recite [] = ""
recite (first : rest) = go (first : rest)
  where
    go (item : next : rest) =
      "For want of a " ++ item ++ " the " ++ next ++ " was lost.\n"
        ++ go (next : rest)
    go [_] = "And all for the want of a " ++ first ++ "."
    go [] = ""
