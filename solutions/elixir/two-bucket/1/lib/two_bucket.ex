defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  @doc """
  Find the quickest way to fill a bucket with some amount of water from two buckets of specific sizes.
  """
  @spec measure(
          size_one :: integer,
          size_two :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}
  def measure(size_one, size_two, goal, start_bucket) do
    start = if start_bucket == :one, do: {size_one, 0}, else: {0, size_two}

    if impossible?(size_one, size_two, goal) do
      {:error, :impossible}
    else
      search(
        :queue.in({start, 1}, :queue.new()),
        MapSet.new([start]),
        size_one,
        size_two,
        goal,
        start_bucket
      )
    end
  end

  defp impossible?(size_one, size_two, goal) do
    goal < 0 or goal > max(size_one, size_two) or
      (goal != 0 and rem(goal, Integer.gcd(size_one, size_two)) != 0)
  end

  defp search(queue, seen, size_one, size_two, goal, start_bucket) do
    case :queue.out(queue) do
      {:empty, _queue} ->
        {:error, :impossible}

      {{:value, {{one, two}, moves}}, rest} ->
        if one == goal or two == goal do
          {:ok, %TwoBucket{bucket_one: one, bucket_two: two, moves: moves}}
        else
          next_states = actions(one, two, size_one, size_two, start_bucket)

          {queue, seen} =
            Enum.reduce(next_states, {rest, seen}, fn state, {queue, seen} ->
              if MapSet.member?(seen, state) do
                {queue, seen}
              else
                {:queue.in({state, moves + 1}, queue), MapSet.put(seen, state)}
              end
            end)

          search(queue, seen, size_one, size_two, goal, start_bucket)
        end
    end
  end

  defp actions(one, two, size_one, size_two, start_bucket) do
    poured_to_two = min(one, size_two - two)
    poured_to_one = min(two, size_one - one)

    [
      {size_one, two},
      {one, size_two},
      {0, two},
      {one, 0},
      {one - poured_to_two, two + poured_to_two},
      {one + poured_to_one, two - poured_to_one}
    ]
    |> Enum.uniq()
    |> Enum.reject(fn {next_one, next_two} ->
      (start_bucket == :one and next_one == 0 and next_two == size_two) or
        (start_bucket == :two and next_two == 0 and next_one == size_one)
    end)
  end
end
