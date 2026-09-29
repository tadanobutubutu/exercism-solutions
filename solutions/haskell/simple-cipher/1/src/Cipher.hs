module Cipher (caesarDecode, caesarEncode, caesarEncodeRandom) where

import Control.Monad (replicateM)
import Data.Char (chr, ord)
import System.Random (randomRIO)

caesarDecode :: String -> String -> String
caesarDecode key =
  zipWith (\shift character -> shiftCharacter (negate shift) character) (shiftSequence key)

caesarEncode :: String -> String -> String
caesarEncode key = zipWith shiftCharacter (shiftSequence key)

shiftSequence :: String -> [Int]
shiftSequence [] = repeat 0
shiftSequence key = cycle (map (\character -> ord character - ord 'a') key)

shiftCharacter :: Int -> Char -> Char
shiftCharacter shift character =
  chr (ord 'a' + (ord character - ord 'a' + shift) `mod` 26)

caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
  shifts <- replicateM (max 1 (length text)) (randomRIO (0, 25))
  let key = map (\shift -> chr (ord 'a' + shift)) shifts
  pure (key, caesarEncode key text)
