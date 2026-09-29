module ResistorColors (Color(..), Resistor(..), label, ohms) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

label :: Resistor -> String
label resistor
  | resistance < 1000 = show resistance ++ " ohms"
  | resistance < 1000000 = format 1000 "kiloohms"
  | resistance < 1000000000 = format 1000000 "megaohms"
  | otherwise = format 1000000000 "gigaohms"
  where
    resistance = ohms resistor
    format scale unit =
      let (whole, remainder) = resistance `divMod` scale
          value = if remainder == 0
            then show whole
            else show whole ++ "." ++ show (remainder `div` (scale `div` 10))
      in value ++ " " ++ unit

ohms :: Resistor -> Int
ohms (Resistor (first, second, multiplier)) =
  (10 * fromEnum first + fromEnum second) * 10 ^ fromEnum multiplier
