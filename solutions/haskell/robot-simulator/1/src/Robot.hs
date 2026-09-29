module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot Bearing Integer Integer

bearing :: Robot -> Bearing
bearing (Robot direction _ _) = direction

coordinates :: Robot -> (Integer, Integer)
coordinates (Robot _ x y) = (x, y)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction (x, y) = Robot direction x y

move :: Robot -> String -> Robot
move = foldl applyInstruction
  where
    applyInstruction (Robot direction x y) instruction = case instruction of
      'R' -> Robot (turnRight direction) x y
      'L' -> Robot (turnLeft direction) x y
      'A' -> advance direction x y
      _ -> Robot direction x y

    turnRight North = East
    turnRight East = South
    turnRight South = West
    turnRight West = North

    turnLeft North = West
    turnLeft West = South
    turnLeft South = East
    turnLeft East = North

    advance North x y = Robot North x (y + 1)
    advance South x y = Robot South x (y - 1)
    advance East x y = Robot East (x + 1) y
    advance West x y = Robot West (x - 1) y
