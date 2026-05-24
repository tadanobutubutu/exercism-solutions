export class Zipper {
  constructor(tree, parent, direction) {
    this._tree = tree;
    this._parent = parent;
    this._direction = direction;
  }

  static fromTree(tree) {
    return new Zipper(tree, null, null);
  }

  toTree() {
    let focus = this._tree;
    let parent = this._parent;
    let direction = this._direction;
    while (parent !== null) {
      const pt = parent._tree;
      focus = {
        value: pt.value,
        left: direction === 'left' ? focus : pt.left,
        right: direction === 'right' ? focus : pt.right,
      };
      direction = parent._direction;
      parent = parent._parent;
    }
    return focus;
  }

  value() {
    return this._tree.value;
  }

  left() {
    if (this._tree.left === null) return null;
    return new Zipper(this._tree.left, this, 'left');
  }

  right() {
    if (this._tree.right === null) return null;
    return new Zipper(this._tree.right, this, 'right');
  }

  up() {
    if (this._parent === null) return null;
    const pt = this._parent._tree;
    const newTree = {
      value: pt.value,
      left: this._direction === 'left' ? this._tree : pt.left,
      right: this._direction === 'right' ? this._tree : pt.right,
    };
    return new Zipper(newTree, this._parent._parent, this._parent._direction);
  }

  setValue(value) {
    const newTree = { value, left: this._tree.left, right: this._tree.right };
    return new Zipper(newTree, this._parent, this._direction);
  }

  setLeft(left) {
    const newTree = { value: this._tree.value, left, right: this._tree.right };
    return new Zipper(newTree, this._parent, this._direction);
  }

  setRight(right) {
    const newTree = { value: this._tree.value, left: this._tree.left, right };
    return new Zipper(newTree, this._parent, this._direction);
  }
}
