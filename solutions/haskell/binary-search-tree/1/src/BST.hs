module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

data BST a = Empty | Node (BST a) a (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Empty = Nothing
bstLeft (Node left _ _) = Just left

bstRight :: BST a -> Maybe (BST a)
bstRight Empty = Nothing
bstRight (Node _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Empty = Nothing
bstValue (Node _ value _) = Just value

empty :: BST a
empty = Empty

fromList :: Ord a => [a] -> BST a
fromList = foldl (flip insert) empty

insert :: Ord a => a -> BST a -> BST a
insert value Empty = singleton value
insert value (Node left root right)
  | value <= root = Node (insert value left) root right
  | otherwise = Node left root (insert value right)

singleton :: a -> BST a
singleton value = Node Empty value Empty

toList :: BST a -> [a]
toList Empty = []
toList (Node left value right) = toList left ++ [value] ++ toList right
