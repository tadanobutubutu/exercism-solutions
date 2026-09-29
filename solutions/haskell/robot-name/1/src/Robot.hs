module Robot (Robot, initialState, mkRobot, resetName, robotName) where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.State (StateT)
import Control.Monad.State (get, put)
import Data.Char (chr)
import Data.IORef (IORef, newIORef, readIORef, writeIORef)
import qualified Data.Set as Set

newtype Robot = Robot (IORef String)
data RunState = RunState Int (Set.Set String)

initialState :: RunState
initialState = RunState 0 Set.empty

mkRobot :: StateT RunState IO Robot
mkRobot = do
  name <- freshName
  Robot <$> liftIO (newIORef name)

resetName :: Robot -> StateT RunState IO ()
resetName (Robot ref) = do
  oldName <- liftIO (readIORef ref)
  RunState next used <- get
  put (RunState next (Set.delete oldName used))
  newName <- freshName
  liftIO (writeIORef ref newName)

robotName :: Robot -> IO String
robotName (Robot ref) = readIORef ref

freshName :: StateT RunState IO String
freshName = do
  RunState next used <- get
  case findAvailable used next 0 of
    Nothing -> error "All robot names have been used."
    Just (index, name) -> do
      put (RunState ((index + 1) `mod` nameCount) (Set.insert name used))
      pure name
  where
    findAvailable _ _ attempts | attempts >= nameCount = Nothing
    findAvailable usedNames index attempts =
      let name = nameAt index
      in if Set.member name usedNames
           then findAvailable usedNames ((index + 1) `mod` nameCount) (attempts + 1)
           else Just (index, name)

nameCount :: Int
nameCount = 26 * 26 * 1000

nameAt :: Int -> String
nameAt index =
  [ chr (fromEnum 'A' + index `div` 26000)
  , chr (fromEnum 'A' + (index `div` 1000) `mod` 26)
  , chr (fromEnum '0' + (index `div` 100) `mod` 10)
  , chr (fromEnum '0' + (index `div` 10) `mod` 10)
  , chr (fromEnum '0' + index `mod` 10)
  ]
