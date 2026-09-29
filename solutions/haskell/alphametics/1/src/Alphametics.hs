module Alphametics (solve) where

import Data.List (nub)

solve :: String -> Maybe [(Char, Int)]
solve puzzle = do
  let (leftSide, rightSide) = break (== "==") (words puzzle)
      addends = filter (/= "+") leftSide
      result = case rightSide of
        (_ : word : _) -> word
        _ -> ""
      letters = nub (concat (addends ++ [result]))
      leading = nub [head word | word <- addends ++ [result], length word > 1]
      width = length result
      addendWidth = maximum (0 : map length addends)
  if null addends || null result || length letters > 10 || width < addendWidth
    then Nothing
    else searchColumns addends result leading width 0 0 []

searchColumns :: [String] -> String -> [Char] -> Int -> Int -> Int -> [(Char, Int)] -> Maybe [(Char, Int)]
searchColumns addends result leading width column carry mapping
  | column >= width = if carry == 0 then Just mapping else Nothing
  | otherwise =
      let addendChars = [word !! (length word - column - 1) | word <- addends, length word > column]
          resultChar = result !! (length result - column - 1)
          partials = assignAddendChars addendChars mapping 0 leading
      in firstJust
           [ let value = sumDigits + carry
                 requiredDigit = value `mod` 10
                 nextCarry = value `div` 10
             in case assignResult resultChar requiredDigit currentMapping leading of
                  Nothing -> Nothing
                  Just nextMapping ->
                    searchColumns addends result leading width (column + 1) nextCarry nextMapping
           | (currentMapping, sumDigits) <- partials
           ]

assignAddendChars :: [Char] -> [(Char, Int)] -> Int -> [Char] -> [([(Char, Int)], Int)]
assignAddendChars [] mapping total _ = [(mapping, total)]
assignAddendChars (letter : rest) mapping total leading =
  case lookup letter mapping of
    Just digit -> assignAddendChars rest mapping (total + digit) leading
    Nothing -> concat
      [ assignAddendChars rest ((letter, digit) : mapping) (total + digit) leading
      | digit <- [0 .. 9]
      , digit `notElem` map snd mapping
      , digit /= 0 || letter `notElem` leading
      ]

assignResult :: Char -> Int -> [(Char, Int)] -> [Char] -> Maybe [(Char, Int)]
assignResult letter digit mapping leading =
  case lookup letter mapping of
    Just existing -> if existing == digit then Just mapping else Nothing
    Nothing
      | digit `elem` map snd mapping -> Nothing
      | digit == 0 && letter `elem` leading -> Nothing
      | otherwise -> Just ((letter, digit) : mapping)

firstJust :: [Maybe a] -> Maybe a
firstJust [] = Nothing
firstJust (Nothing : rest) = firstJust rest
firstJust (result : _) = result
