# Globals for the directions
NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3


class Robot:
    def __init__(self, direction=NORTH, x_pos=0, y_pos=0):
        self.direction = direction
        self.coordinates = (x_pos, y_pos)

    def move(self, commands):
        for cmd in commands:
            if cmd == 'R':
                self.direction = (self.direction + 1) % 4
            elif cmd == 'L':
                self.direction = (self.direction - 1) % 4
            elif cmd == 'A':
                x, y = self.coordinates
                if self.direction == NORTH:
                    y += 1
                elif self.direction == EAST:
                    x += 1
                elif self.direction == SOUTH:
                    y -= 1
                elif self.direction == WEST:
                    x -= 1
                self.coordinates = (x, y)
