defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: %__MODULE__{
            state: :ready | :running | :stopped,
            current_lap_seconds: non_neg_integer(),
            total_seconds: non_neg_integer(),
            previous_laps_seconds: [non_neg_integer()]
          }

    defstruct state: :ready,
              current_lap_seconds: 0,
              total_seconds: 0,
              previous_laps_seconds: []
  end

  @spec new() :: Stopwatch.t()
  def new() do
    %Stopwatch{}
  end

  @spec state(Stopwatch.t()) :: state()
  def state(stopwatch) do
    stopwatch.state
  end

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(stopwatch) do
    to_time(stopwatch.current_lap_seconds)
  end

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(stopwatch) do
    Enum.map(stopwatch.previous_laps_seconds, &to_time/1)
  end

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(stopwatch, time) do
    if stopwatch.state == :running do
      seconds = time_to_seconds(time)

      %{
        stopwatch
        | current_lap_seconds: stopwatch.current_lap_seconds + seconds,
          total_seconds: stopwatch.total_seconds + seconds
      }
    else
      stopwatch
    end
  end

  @spec total(Stopwatch.t()) :: Time.t()
  def total(stopwatch) do
    to_time(stopwatch.total_seconds)
  end

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(stopwatch) do
    if stopwatch.state == :running do
      {:error, "cannot start an already running stopwatch"}
    else
      %{stopwatch | state: :running}
    end
  end

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(stopwatch) do
    if stopwatch.state == :running do
      %{stopwatch | state: :stopped}
    else
      {:error, "cannot stop a stopwatch that is not running"}
    end
  end

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def lap(stopwatch) do
    if stopwatch.state == :running do
      %{
        stopwatch
        | previous_laps_seconds:
            stopwatch.previous_laps_seconds ++ [stopwatch.current_lap_seconds],
          current_lap_seconds: 0
      }
    else
      {:error, "cannot lap a stopwatch that is not running"}
    end
  end

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def reset(stopwatch) do
    if stopwatch.state == :stopped do
      new()
    else
      {:error, "cannot reset a stopwatch that is not stopped"}
    end
  end

  defp time_to_seconds(%Time{hour: hour, minute: minute, second: second}),
    do: hour * 3600 + minute * 60 + second

  defp to_time(seconds), do: Time.add(~T[00:00:00], seconds, :second)
end
