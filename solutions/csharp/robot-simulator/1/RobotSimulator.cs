public enum Direction
{
    North,
    East,
    South,
    West
}

public class RobotSimulator
{
    private Direction direction;
    private int x;
    private int y;

    public RobotSimulator(Direction direction, int x, int y)
    {
        this.direction = direction;
        this.x = x;
        this.y = y;
    }

    public Direction Direction
    {
        get
        {
            return direction;
        }
    }

    public int X
    {
        get
        {
            return x;
        }
    }

    public int Y
    {
        get
        {
            return y;
        }
    }

    public void Move(string instructions)
    {
        ArgumentNullException.ThrowIfNull(instructions);

        foreach (char instruction in instructions)
        {
            switch (instruction)
            {
                case 'R':
                    direction = (Direction)(((int)direction + 1) % 4);
                    break;
                case 'L':
                    direction = (Direction)(((int)direction + 3) % 4);
                    break;
                case 'A':
                    switch (direction)
                    {
                        case Direction.North: y++; break;
                        case Direction.East: x++; break;
                        case Direction.South: y--; break;
                        case Direction.West: x--; break;
                        default: throw new InvalidOperationException("The robot has an invalid direction.");
                    }
                    break;
                default:
                    throw new ArgumentException($"Unknown instruction: {instruction}", nameof(instructions));
            }
        }
    }
}
