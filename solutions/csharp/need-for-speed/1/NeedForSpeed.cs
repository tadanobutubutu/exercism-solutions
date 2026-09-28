class RemoteControlCar
{
    private readonly int _speed;
    private readonly int _batteryDrain;
    private int _battery = 100;
    private int _distance;

    public RemoteControlCar(int speed, int batteryDrain)
    {
        _speed = speed;
        _batteryDrain = batteryDrain;
    }

    public bool BatteryDrained()
    {
        return _battery < _batteryDrain;
    }

    public int DistanceDriven()
    {
        return _distance;
    }

    public void Drive()
    {
        if (BatteryDrained()) return;
        _distance += _speed;
        _battery -= _batteryDrain;
    }

    public static RemoteControlCar Nitro()
    {
        return new RemoteControlCar(50, 4);
    }

    internal bool CanFinishDistance(int distance)
    {
        if (distance <= 0) return true;
        if (_speed <= 0) return false;
        var drivesNeeded = ((long)distance + _speed - 1) / _speed;
        var availableDrives = _batteryDrain <= 0 ? long.MaxValue : 100L / _batteryDrain;
        return drivesNeeded <= availableDrives;
    }
}

class RaceTrack
{
    private readonly int _distance;

    public RaceTrack(int distance)
    {
        _distance = distance;
    }

    public bool TryFinishTrack(RemoteControlCar car)
    {
        return car.CanFinishDistance(_distance);
    }
}
