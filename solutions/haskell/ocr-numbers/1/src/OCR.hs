module OCR (convert) where

import Data.List (intercalate)

convert :: String -> String
convert input = intercalate "," (map convertGroup (chunksOf 4 (lines input)))
  where
    convertGroup rows =
      [ decodeGlyph [take 3 (drop offset row ++ repeat ' ') | row <- paddedRows]
      | offset <- [0, 3 .. width - 1]
      ]
      where
        paddedRows = take 4 (rows ++ repeat "")
        width = maximum (0 : map length paddedRows)

    decodeGlyph rows = maybe '?' id (lookup rows glyphs)

    glyphs =
      [ ([" _ ", "| |", "|_|", "   "], '0')
      , (["   ", "  |", "  |", "   "], '1')
      , ([" _ ", " _|", "|_ ", "   "], '2')
      , ([" _ ", " _|", " _|", "   "], '3')
      , (["   ", "|_|", "  |", "   "], '4')
      , ([" _ ", "|_ ", " _|", "   "], '5')
      , ([" _ ", "|_ ", "|_|", "   "], '6')
      , ([" _ ", "  |", "  |", "   "], '7')
      , ([" _ ", "|_|", "|_|", "   "], '8')
      , ([" _ ", "|_|", " _|", "   "], '9')
      ]

    chunksOf _ [] = []
    chunksOf size values = take size values : chunksOf size (drop size values)
