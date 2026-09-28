public static class Prism
{
    public readonly record struct LaserInfo(double X, double Y, double Angle);

    public readonly record struct PrismInfo(int Id, double X, double Y, double Angle);

    public static int[] FindSequence(LaserInfo laser, PrismInfo[] prisms)
    {
        ArgumentNullException.ThrowIfNull(prisms);

        const double epsilon = 1e-6;
        double x = laser.X;
        double y = laser.Y;
        double angle = Normalize(laser.Angle);
        var sequence = new List<int>();
        var visitedStates = new HashSet<(double X, double Y, double Angle)>();

        while (visitedStates.Add((x, y, angle)))
        {
            double radians = double.DegreesToRadians(angle);
            double directionX = double.Cos(radians);
            double directionY = double.Sin(radians);
            PrismInfo? nearest = null;
            double nearestDistance = double.PositiveInfinity;

            foreach (PrismInfo prism in prisms)
            {
                double dx = prism.X - x;
                double dy = prism.Y - y;
                double distance = dx * directionX + dy * directionY;
                if (distance <= epsilon)
                {
                    continue;
                }

                double perpendicularX = dx - distance * directionX;
                double perpendicularY = dy - distance * directionY;
                double perpendicularDistanceSquared = perpendicularX * perpendicularX + perpendicularY * perpendicularY;
                if (perpendicularDistanceSquared >= epsilon * Math.Max(1, distance * distance))
                {
                    continue;
                }

                if (distance < nearestDistance)
                {
                    nearestDistance = distance;
                    nearest = prism;
                }
            }

            if (nearest is not PrismInfo hit)
            {
                break;
            }

            sequence.Add(hit.Id);
            x = hit.X;
            y = hit.Y;
            angle = Normalize(angle + hit.Angle);
        }

        return sequence.ToArray();
    }

    private static double Normalize(double angle)
    {
        double normalized = angle % 360;
        return normalized < 0 ? normalized + 360 : normalized;
    }
}
