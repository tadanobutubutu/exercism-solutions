module ProteinTranslation(proteins) where

proteins :: String -> Maybe [String]
proteins [] = Just []
proteins (first : second : third : rest) =
  case translate [first, second, third] of
    Nothing -> Nothing
    Just Nothing -> Just []
    Just (Just protein) -> (protein :) <$> proteins rest
proteins _ = Nothing

translate :: String -> Maybe (Maybe String)
translate codon = case codon of
  "AUG" -> amino "Methionine"
  "UUU" -> amino "Phenylalanine"
  "UUC" -> amino "Phenylalanine"
  "UUA" -> amino "Leucine"
  "UUG" -> amino "Leucine"
  "UCU" -> amino "Serine"
  "UCC" -> amino "Serine"
  "UCA" -> amino "Serine"
  "UCG" -> amino "Serine"
  "UAU" -> amino "Tyrosine"
  "UAC" -> amino "Tyrosine"
  "UGU" -> amino "Cysteine"
  "UGC" -> amino "Cysteine"
  "UGG" -> amino "Tryptophan"
  "UAA" -> Just Nothing
  "UAG" -> Just Nothing
  "UGA" -> Just Nothing
  _ -> Nothing
  where
    amino = Just . Just
