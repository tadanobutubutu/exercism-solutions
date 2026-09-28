class Lasagna
{
    public int ExpectedMinutesInOven() => 40;

    public int RemainingMinutesInOven(int actualMinutesInOven) =>
        ExpectedMinutesInOven() - actualMinutesInOven;

    public int PreparationTimeInMinutes(int layers) => layers * 2;

    public int ElapsedTimeInMinutes(int layers, int actualMinutesInOven) =>
        PreparationTimeInMinutes(layers) + actualMinutesInOven;
}
