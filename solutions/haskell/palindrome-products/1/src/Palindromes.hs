module Palindromes (largestPalindrome, smallestPalindrome) where

largestPalindrome :: Integer -> Integer -> Maybe (Integer, [(Integer, Integer)])
largestPalindrome minFactor maxFactor
  | minFactor > maxFactor = Nothing
  | otherwise =
      findPalindrome (reverse (palindromesBetween lower upper))
  where
    lower = productLowerBound minFactor maxFactor
    upper = productUpperBound minFactor maxFactor
    findPalindrome [] = Nothing
    findPalindrome (productValue : rest) =
      case factorPairs productValue minFactor maxFactor of
        [] -> findPalindrome rest
        factors -> Just (productValue, factors)

smallestPalindrome :: Integer -> Integer -> Maybe (Integer, [(Integer, Integer)])
smallestPalindrome minFactor maxFactor
  | minFactor > maxFactor = Nothing
  | otherwise =
      findPalindrome (palindromesBetween lower upper)
  where
    lower = productLowerBound minFactor maxFactor
    upper = productUpperBound minFactor maxFactor
    findPalindrome [] = Nothing
    findPalindrome (productValue : rest) =
      case factorPairs productValue minFactor maxFactor of
        [] -> findPalindrome rest
        factors -> Just (productValue, factors)

palindromesBetween :: Integer -> Integer -> [Integer]
palindromesBetween lower upper
  | lower > upper || upper < 0 = []
  | otherwise =
      ([0 | lower <= 0] ++
      [ value
      | digits <- [digitCount (max 1 lower) .. digitCount upper]
      , prefix <- [firstPrefix digits .. lastPrefix digits]
      , let value = makePalindrome digits prefix
      , value >= lower
      , value <= upper
      ])
  where
    halfLength digits = (digits + 1) `div` 2
    firstPrefix digits = 10 ^ (halfLength digits - 1)
    lastPrefix digits = 10 ^ halfLength digits - 1

digitCount :: Integer -> Int
digitCount value
  | value < 10 = 1
  | otherwise = 1 + digitCount (value `div` 10)

productLowerBound :: Integer -> Integer -> Integer
productLowerBound minFactor maxFactor
  | minFactor <= 0 && maxFactor >= 0 = 0
  | otherwise = min (minFactor * minFactor) (maxFactor * maxFactor)

productUpperBound :: Integer -> Integer -> Integer
productUpperBound minFactor maxFactor =
  max (minFactor * minFactor) (maxFactor * maxFactor)

makePalindrome :: Int -> Integer -> Integer
makePalindrome digits prefix = read (prefixText ++ reflected)
  where
    prefixText = show prefix
    mirroredPart
      | odd digits = init prefixText
      | otherwise = prefixText
    reflected = reverse mirroredPart

factorPairs :: Integer -> Integer -> Integer -> [(Integer, Integer)]
factorPairs 0 minFactor maxFactor
  | minFactor > maxFactor = []
  | otherwise =
      [ (first, second)
      | first <- [minFactor .. maxFactor]
      , second <- [first .. maxFactor]
      , first * second == 0
      ]
factorPairs productValue minFactor maxFactor
  | minFactor > maxFactor || productValue < 0 = []
  | otherwise =
      [ (first, second)
      | first <- [minFactor .. min maxFactor (integerSquareRoot productValue)]
      , first /= 0
      , productValue `mod` first == 0
      , let second = productValue `div` first
      , second >= first
      , second <= maxFactor
      ]

integerSquareRoot :: Integer -> Integer
integerSquareRoot value
  | value < 0 = error "integerSquareRoot: negative input"
  | otherwise = search 0 (value + 1)
  where
    search lower upper
      | upper - lower <= 1 = lower
      | midpoint * midpoint <= value = search midpoint upper
      | otherwise = search lower midpoint
      where
        midpoint = (lower + upper) `div` 2
