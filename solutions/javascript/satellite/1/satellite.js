export const treeFromTraversals = (preorder, inorder) => {
  if (preorder.length !== inorder.length) {
    throw new Error('traversals must have the same length');
  }
  if (new Set(preorder).size !== preorder.length || new Set(inorder).size !== inorder.length) {
    throw new Error('traversals must contain unique items');
  }
  if (preorder.some((item) => !inorder.includes(item))) {
    throw new Error('traversals must have the same elements');
  }
  if (preorder.length === 0) return {};

  const inorderIndices = new Map(inorder.map((value, index) => [value, index]));
  let preorderIndex = 0;

  const build = (start, end) => {
    if (start > end) return {};
    const value = preorder[preorderIndex];
    preorderIndex += 1;
    const rootIndex = inorderIndices.get(value);
    if (rootIndex < start || rootIndex > end) {
      throw new Error('traversals must have the same elements');
    }
    return {
      value,
      left: build(start, rootIndex - 1),
      right: build(rootIndex + 1, end),
    };
  };

  return build(0, inorder.length - 1);
};
