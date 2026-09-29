module Poker (bestHands) where

import Data.List (group, sort, sortBy)

bestHands :: [String] -> Maybe [String]
bestHands [] = Nothing
bestHands hands = do
  ranked <- traverse rankHand hands
  let best = maximum (map fst ranked)
  pure [hand | (score, hand) <- ranked, score == best]
  where
    rankHand hand = do
      score <- handScore hand
      pure (score, hand)

handScore :: String -> Maybe [Int]
handScore hand = do
  let cards = words hand
  if length cards /= 5
    then Nothing
    else do
      parsed <- traverse parseCard cards
      let ranks = map fst parsed
          suits = map snd parsed
          flush = all (== head suits) suits
          straight = straightHigh ranks
          counts = sortBy (flip compare)
            [(length sameRank, head sameRank) | sameRank <- group (sort ranks)]
          descendingRanks = sortBy (flip compare) ranks
          remainingRanks =
            concat [replicate count rank | (count, rank) <- counts, count == 1]
          score =
            if flush && straight /= Nothing
              then [8, maybe 0 id straight]
              else case counts of
                [(4, four), (1, kicker)] -> [7, four, kicker]
                [(3, three), (2, pair)] -> [6, three, pair]
                _
                  | flush -> 5 : descendingRanks
                  | Just high <- straight -> [4, high]
                  | (3, three) : _ <- counts -> [3, three] ++ remainingRanks
                  | [(2, high), (2, low), (1, kicker)] <- counts -> [2, high, low, kicker]
                  | (2, pair) : _ <- counts -> [1, pair] ++ remainingRanks
                  | otherwise -> 0 : descendingRanks
      pure score

parseCard :: String -> Maybe (Int, Char)
parseCard card
  | length card < 2 = Nothing
  | suit `notElem` "CDHS" = Nothing
  | otherwise = do
      rank <- rankValue (init card)
      pure (rank, suit)
  where
    suit = last card

rankValue :: String -> Maybe Int
rankValue "J" = Just 11
rankValue "Q" = Just 12
rankValue "K" = Just 13
rankValue "A" = Just 14
rankValue token =
  case reads token of
    [(rank, "")] | rank >= 2 && rank <= 10 -> Just rank
    _ -> Nothing

straightHigh :: [Int] -> Maybe Int
straightHigh ranks
  | sort ranks == [2, 3, 4, 5, 14] = Just 5
  | length (group sortedRanks) == 5 && last sortedRanks - head sortedRanks == 4 = Just (last sortedRanks)
  | otherwise = Nothing
  where
    sortedRanks = sort ranks
