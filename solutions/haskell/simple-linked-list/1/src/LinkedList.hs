module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Nil | Cons a (LinkedList a) deriving (Eq, Show)

datum :: LinkedList a -> a
datum (Cons x _) = x
datum Nil = error "datum: empty linked list"

fromList :: [a] -> LinkedList a
fromList = foldr Cons Nil

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _   = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

next :: LinkedList a -> LinkedList a
next (Cons _ xs) = xs
next Nil = Nil

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = go Nil
  where
    go acc Nil = acc
    go acc (Cons x xs) = go (Cons x acc) xs

toList :: LinkedList a -> [a]
toList Nil = []
toList (Cons x xs) = x : toList xs
