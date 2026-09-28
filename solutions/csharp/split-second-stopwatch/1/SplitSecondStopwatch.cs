public enum StopwatchState
{
    Ready,
    Running,
    Stopped
}

public class SplitSecondStopwatch
{
    private readonly TimeProvider _time;
    private readonly List<TimeSpan> _previousLaps = [];
    private StopwatchState _state = StopwatchState.Ready;
    private TimeSpan _currentLapElapsed;
    private TimeSpan _totalElapsed;
    private long _startedAt;

    public SplitSecondStopwatch(TimeProvider time) =>
        _time = time ?? throw new ArgumentNullException(nameof(time));

    public StopwatchState State => _state;
    public TimeSpan CurrentLap => _currentLapElapsed + RunningElapsed();
    public TimeSpan Total => _totalElapsed + RunningElapsed();
    public IReadOnlyCollection<TimeSpan> PreviousLaps => _previousLaps.AsReadOnly();

    public void Start()
    {
        if (_state == StopwatchState.Running)
            throw new InvalidOperationException("The stopwatch is already running.");

        _startedAt = _time.GetTimestamp();
        _state = StopwatchState.Running;
    }

    public void Stop()
    {
        if (_state != StopwatchState.Running)
            throw new InvalidOperationException("The stopwatch is not running.");

        AccumulateRunningTime();
        _state = StopwatchState.Stopped;
    }

    public void Reset()
    {
        if (_state != StopwatchState.Stopped)
            throw new InvalidOperationException("The stopwatch must be stopped before resetting.");

        _currentLapElapsed = TimeSpan.Zero;
        _totalElapsed = TimeSpan.Zero;
        _previousLaps.Clear();
        _state = StopwatchState.Ready;
    }

    public void Lap()
    {
        if (_state != StopwatchState.Running)
            throw new InvalidOperationException("A lap can only be recorded while running.");

        long now = _time.GetTimestamp();
        TimeSpan elapsed = _time.GetElapsedTime(_startedAt, now);
        _currentLapElapsed += elapsed;
        _totalElapsed += elapsed;
        _previousLaps.Add(_currentLapElapsed);
        _currentLapElapsed = TimeSpan.Zero;
        _startedAt = now;
    }

    private TimeSpan RunningElapsed() => _state == StopwatchState.Running
        ? _time.GetElapsedTime(_startedAt)
        : TimeSpan.Zero;

    private void AccumulateRunningTime()
    {
        TimeSpan elapsed = RunningElapsed();
        _currentLapElapsed += elapsed;
        _totalElapsed += elapsed;
    }
}
