module Prime (nth) where

nth :: Int -> Maybe Integer
nth n
  | n < 1 = Nothing
  | otherwise = case drop (n - 1) primes of
      prime : _ -> Just prime
      [] -> Nothing
  where
    primes :: [Integer]
    primes = 2 : filter isPrime [3, 5 ..]

    isPrime candidate =
      all (\prime -> candidate `mod` prime /= 0)
        (takeWhile (\prime -> prime * prime <= candidate) primes)
