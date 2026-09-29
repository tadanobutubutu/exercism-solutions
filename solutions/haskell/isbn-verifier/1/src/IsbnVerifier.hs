module IsbnVerifier (isbn) where

isbn :: String -> Bool
isbn input =
  case filter (/= '-') input of
    digits
      | length digits == 10
      , all isAsciiDigit (take 9 digits)
      , validCheckDigit (last digits) ->
          sum (zipWith (*) [10, 9 .. 1] (map value digits)) `mod` 11 == 0
    _ -> False
  where
    isAsciiDigit c = c >= '0' && c <= '9'
    validCheckDigit c = isAsciiDigit c || c == 'X'
    value 'X' = 10
    value c = fromEnum c - fromEnum '0'
