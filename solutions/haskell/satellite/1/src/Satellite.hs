module Satellite (treeFromTraversals) where

import BinaryTree (BinaryTree(..))
import Data.List (nub, sort)

treeFromTraversals :: Ord a => [a] -> [a] -> Maybe (BinaryTree a)
treeFromTraversals [] [] = Nothing
treeFromTraversals preorder inorder
  | length preorder /= length inorder = Nothing
  | length (nub preorder) /= length preorder = Nothing
  | sort preorder /= sort inorder = Nothing
  | otherwise = build preorder inorder
  where
    build [] [] = Just Leaf
    build (root : remainingPreorder) remainingInorder =
      case break (== root) remainingInorder of
        (leftInorder, _ : rightInorder) -> do
          let (leftPreorder, rightPreorder) =
                splitAt (length leftInorder) remainingPreorder
          left <- build leftPreorder leftInorder
          right <- build rightPreorder rightInorder
          pure (Branch left root right)
        _ -> Nothing
    build _ _ = Nothing
