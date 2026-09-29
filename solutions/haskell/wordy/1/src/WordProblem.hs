module WordProblem (answer) where

import Text.Read (readMaybe)

answer :: String -> Maybe Integer
answer problem = do
  expression <- stripQuestion problem
  case words expression of
    "What" : "is" : first : rest -> do
      initial <- readMaybe first
      evaluate initial rest
    _ -> Nothing
  where
    stripQuestion text = case reverse text of
      '?' : reversed -> Just (reverse reversed)
      _ -> Nothing

    evaluate value [] = Just value
    evaluate value ("plus" : number : rest) =
      readMaybe number >>= \operand -> evaluate (value + operand) rest
    evaluate value ("minus" : number : rest) =
      readMaybe number >>= \operand -> evaluate (value - operand) rest
    evaluate value ("multiplied" : "by" : number : rest) =
      readMaybe number >>= \operand -> evaluate (value * operand) rest
    evaluate value ("divided" : "by" : number : rest) = do
      operand <- readMaybe number
      if operand == 0 then Nothing else evaluate (value `div` operand) rest
    evaluate _ _ = Nothing
