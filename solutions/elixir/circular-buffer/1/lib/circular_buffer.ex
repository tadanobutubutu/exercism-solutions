defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer.
  """

  @doc "Create a new buffer of a given capacity."
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(CircularBuffer.Server, max(capacity, 0))
  end

  @doc "Read the oldest entry in the buffer, failing if it is empty."
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer), do: GenServer.call(buffer, :read)

  @doc "Write a new item in the buffer, failing if it is full."
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item), do: GenServer.call(buffer, {:write, item})

  @doc "Write an item, overwriting the oldest entry when full."
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item), do: GenServer.call(buffer, {:overwrite, item})

  @doc "Clear the buffer."
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer), do: GenServer.call(buffer, :clear)
end

defmodule CircularBuffer.Server do
  use GenServer

  @impl true
  def init(capacity), do: {:ok, {capacity, :queue.new()}}

  @impl true
  def handle_call(:read, _from, {capacity, queue}) do
    case :queue.out(queue) do
      {{:value, item}, remaining} -> {:reply, {:ok, item}, {capacity, remaining}}
      {:empty, _queue} -> {:reply, {:error, :empty}, {capacity, queue}}
    end
  end

  def handle_call({:write, item}, _from, {capacity, queue} = state) do
    if :queue.len(queue) >= capacity do
      {:reply, {:error, :full}, state}
    else
      {:reply, :ok, {capacity, :queue.in(item, queue)}}
    end
  end

  def handle_call({:overwrite, item}, _from, {capacity, queue}) do
    queue =
      if :queue.len(queue) >= capacity do
        case :queue.out(queue) do
          {{:value, _oldest}, remaining} -> remaining
          {:empty, _queue} -> queue
        end
      else
        queue
      end

    {:reply, :ok, {capacity, :queue.in(item, queue)}}
  end

  def handle_call(:clear, _from, {capacity, _queue}) do
    {:reply, :ok, {capacity, :queue.new()}}
  end
end
