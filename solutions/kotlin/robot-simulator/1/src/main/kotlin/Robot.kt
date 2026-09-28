class Robot {
    var gridPosition: GridPosition = GridPosition(0, 0)
        private set
    var orientation: Orientation = Orientation.NORTH
        private set

    constructor()

    constructor(gridPosition: GridPosition, orientation: Orientation) {
        this.gridPosition = gridPosition
        this.orientation = orientation
    }

    fun simulate(instructions: String) {
        for (instruction in instructions) {
            when (instruction) {
                'R' -> orientation = Orientation.values()[(orientation.ordinal + 1) % Orientation.values().size]
                'L' -> orientation = Orientation.values()[(orientation.ordinal + Orientation.values().size - 1) % Orientation.values().size]
                'A' -> gridPosition = when (orientation) {
                    Orientation.NORTH -> gridPosition.copy(y = gridPosition.y + 1)
                    Orientation.EAST -> gridPosition.copy(x = gridPosition.x + 1)
                    Orientation.SOUTH -> gridPosition.copy(y = gridPosition.y - 1)
                    Orientation.WEST -> gridPosition.copy(x = gridPosition.x - 1)
                }
            }
        }
    }
}
