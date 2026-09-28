public class RemoteControlCar
{
    public string CurrentSponsor { get; private set; } = string.Empty;
    public ITelemetry Telemetry { get; }

    private Speed currentSpeed;

    public RemoteControlCar()
    {
        Telemetry = new TelemetrySystem(this);
    }

    public string GetSpeed() => currentSpeed.ToString();

    private void Calibrate() { }

    private bool SelfTest() => true;

    private void SetSponsor(string sponsorName) => CurrentSponsor = sponsorName;

    private void SetSpeed(Speed speed) => currentSpeed = speed;

    public interface ITelemetry
    {
        void Calibrate();
        bool SelfTest();
        void ShowSponsor(string sponsorName);
        void SetSpeed(decimal amount, string unitsString);
    }

    private sealed class TelemetrySystem : ITelemetry
    {
        private readonly RemoteControlCar car;

        public TelemetrySystem(RemoteControlCar car) => this.car = car;

        public void Calibrate() => car.Calibrate();

        public bool SelfTest() => car.SelfTest();

        public void ShowSponsor(string sponsorName) => car.SetSponsor(sponsorName);

        public void SetSpeed(decimal amount, string unitsString)
        {
            SpeedUnits units = unitsString == "cps"
                ? SpeedUnits.CentimetersPerSecond
                : SpeedUnits.MetersPerSecond;
            car.SetSpeed(new Speed(amount, units));
        }
    }

    private enum SpeedUnits
    {
        MetersPerSecond,
        CentimetersPerSecond
    }

    private struct Speed
    {
        public decimal Amount { get; }
        public SpeedUnits Units { get; }

        public Speed(decimal amount, SpeedUnits units)
        {
            Amount = amount;
            Units = units;
        }

        public override string ToString()
        {
            string unitsString = Units == SpeedUnits.CentimetersPerSecond
                ? "centimeters per second"
                : "meters per second";
            return $"{Amount} {unitsString}";
        }
    }
}
