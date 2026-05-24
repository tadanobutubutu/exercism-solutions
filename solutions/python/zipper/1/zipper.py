class Zipper:
    def __init__(self, tree, crumbs=None):
        self._tree = tree
        self._crumbs = crumbs or []

    @staticmethod
    def from_tree(tree):
        return Zipper(tree)

    def value(self):
        return self._tree["value"]

    def set_value(self, value):
        return Zipper(
            {"value": value, "left": self._tree["left"], "right": self._tree["right"]},
            self._crumbs,
        )

    def left(self):
        if self._tree["left"] is None:
            return None
        return Zipper(
            self._tree["left"],
            self._crumbs + [("left", self._tree["value"], self._tree["right"])],
        )

    def set_left(self, tree):
        return Zipper(
            {"value": self._tree["value"], "left": tree, "right": self._tree["right"]},
            self._crumbs,
        )

    def right(self):
        if self._tree["right"] is None:
            return None
        return Zipper(
            self._tree["right"],
            self._crumbs + [("right", self._tree["value"], self._tree["left"])],
        )

    def set_right(self, tree):
        return Zipper(
            {"value": self._tree["value"], "left": self._tree["left"], "right": tree},
            self._crumbs,
        )

    def up(self):
        if not self._crumbs:
            return None
        direction, val, sibling = self._crumbs[-1]
        rest = self._crumbs[:-1]
        if direction == "left":
            return Zipper(
                {"value": val, "left": self._tree, "right": sibling}, rest
            )
        return Zipper(
            {"value": val, "left": sibling, "right": self._tree}, rest
        )

    def to_tree(self):
        z = self
        while True:
            u = z.up()
            if u is None:
                break
            z = u
        return z._tree

    def __eq__(self, other):
        return self.to_tree() == other.to_tree()
