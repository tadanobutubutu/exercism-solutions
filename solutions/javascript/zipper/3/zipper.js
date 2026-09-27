//
// This is only a SKELETON file for the 'Zipper' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Zipper {
  constructor(focus, crumbs = []) {
    this._focus = focus;
    this._crumbs = crumbs;
  }

  static fromTree(tree) {
    return tree === null ? null : new Zipper(tree);
  }

  toTree() {
    let tree = this._focus;
    for (const crumb of this._crumbs) {
      tree = crumb.direction === 'left'
        ? { value: crumb.value, left: tree, right: crumb.sibling }
        : { value: crumb.value, left: crumb.sibling, right: tree };
    }
    return tree;
  }

  value() {
    return this._focus.value;
  }

  left() {
    return this._focus.left === null
      ? null
      : new Zipper(this._focus.left, [
          { direction: 'left', value: this._focus.value, sibling: this._focus.right },
          ...this._crumbs,
        ]);
  }

  right() {
    return this._focus.right === null
      ? null
      : new Zipper(this._focus.right, [
          { direction: 'right', value: this._focus.value, sibling: this._focus.left },
          ...this._crumbs,
        ]);
  }

  up() {
    if (this._crumbs.length === 0) return null;
    const [crumb, ...rest] = this._crumbs;
    const parent = crumb.direction === 'left'
      ? { value: crumb.value, left: this._focus, right: crumb.sibling }
      : { value: crumb.value, left: crumb.sibling, right: this._focus };
    return new Zipper(parent, rest);
  }

  setValue(value) {
    return new Zipper({ ...this._focus, value }, this._crumbs);
  }

  setLeft(left) {
    return new Zipper({ ...this._focus, left }, this._crumbs);
  }

  setRight(right) {
    return new Zipper({ ...this._focus, right }, this._crumbs);
  }
}
