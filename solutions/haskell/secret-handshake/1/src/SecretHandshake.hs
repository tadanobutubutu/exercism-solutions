module SecretHandshake (handshake) where

import Data.Bits (testBit)

handshake :: Int -> [String]
handshake number
  | testBit number 4 = reverse actions
  | otherwise = actions
  where
    actions =
      [ action
      | (bit, action) <-
          [ (0, "wink")
          , (1, "double blink")
          , (2, "close your eyes")
          , (3, "jump")
          ]
      , testBit number bit
      ]
