module Phone (number) where

number :: String -> Maybe String
number input
  | any (not . allowed) input = Nothing
  | length pluses > 1 = Nothing
  | not (null pluses) && not leadingPlus = Nothing
  | not (null pluses) && not countryPrefixed = Nothing
  | length digits == 10 = validate digits
  | length digits == 11 = case digits of
      '1' : localNumber -> validate localNumber
      _ -> Nothing
  | otherwise = Nothing
  where
    digits = filter (\character -> character >= '0' && character <= '9') input
    pluses = filter (== '+') input
    leadingPlus = case input of
      '+' : _ -> True
      _ -> False
    countryPrefixed = case digits of
      '1' : _ -> True
      _ -> False
    allowed character =
      (character >= '0' && character <= '9') || character `elem` " +().-"
    validate localNumber = case localNumber of
      area : _ : _ : exchange : _
        | length localNumber == 10
        , isNanpLead area
        , isNanpLead exchange -> Just localNumber
      _ -> Nothing
    isNanpLead character = character >= '2' && character <= '9'
