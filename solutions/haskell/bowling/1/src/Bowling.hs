module Bowling (score, BowlingError(..)) where

data BowlingError = IncompleteGame
                  | InvalidRoll { rollIndex :: Int, rollValue :: Int }
  deriving (Eq, Show)

score :: [Int] -> Either BowlingError Int
score rolls = do
  (firstNine, nextIndex, afterNine) <- parseFirstNine 1 0 rolls []
  (tenth, extras) <- parseTenth nextIndex afterNine
  case extras of
    extra : _ -> Left (InvalidRoll (nextIndex + length tenth) extra)
    [] -> Right (sum (map (frameScore rolls) firstNine) + sum tenth)

type Frame = (Int, [Int])

parseFirstNine :: Int -> Int -> [Int] -> [Frame] -> Either BowlingError ([Frame], Int, [Int])
parseFirstNine frameNumber index remaining frames
  | frameNumber > 9 = Right (reverse frames, index, remaining)
  | otherwise = do
      (first, afterFirst) <- takeRoll index remaining
      if first == 10
        then parseFirstNine (frameNumber + 1) (index + 1) afterFirst ((index, [first]) : frames)
        else do
          (second, afterSecond) <- takeRoll (index + 1) afterFirst
          if first + second > 10
            then Left (InvalidRoll (index + 1) second)
            else parseFirstNine (frameNumber + 1) (index + 2) afterSecond ((index, [first, second]) : frames)

parseTenth :: Int -> [Int] -> Either BowlingError ([Int], [Int])
parseTenth index rolls = do
  (first, afterFirst) <- takeRoll index rolls
  if first == 10
    then do
      (second, afterSecond) <- takeRoll (index + 1) afterFirst
      (third, afterThird) <- takeRoll (index + 2) afterSecond
      if second < 10 && second + third > 10
        then Left (InvalidRoll (index + 2) third)
        else Right ([first, second, third], afterThird)
    else do
      (second, afterSecond) <- takeRoll (index + 1) afterFirst
      if first + second > 10
        then Left (InvalidRoll (index + 1) second)
        else if first + second == 10
          then do
            (bonus, afterBonus) <- takeRoll (index + 2) afterSecond
            Right ([first, second, bonus], afterBonus)
          else Right ([first, second], afterSecond)

takeRoll :: Int -> [Int] -> Either BowlingError (Int, [Int])
takeRoll _ [] = Left IncompleteGame
takeRoll index (roll : rest)
  | roll < 0 || roll > 10 = Left (InvalidRoll index roll)
  | otherwise = Right (roll, rest)

frameScore :: [Int] -> Frame -> Int
frameScore allRolls (index, [10]) =
  10 + rollAt (index + 1) + rollAt (index + 2)
  where
    rollAt position = allRolls !! position
frameScore allRolls (index, [first, second])
  | first + second == 10 = 10 + allRolls !! (index + 2)
  | otherwise = first + second
frameScore _ (_, pins) = sum pins
