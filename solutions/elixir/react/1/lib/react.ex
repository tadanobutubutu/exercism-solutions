defmodule React do
  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    React.Server.start_link(cells)
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    GenServer.call(cells, {:get_value, cell_name})
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    GenServer.call(cells, {:set_value, cell_name, value})
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
    GenServer.call(cells, {:add_callback, cell_name, callback_name, callback})
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
    GenServer.call(cells, {:remove_callback, cell_name, callback_name})
  end
end

defmodule React.Server do
  use GenServer

  def start_link(cells), do: GenServer.start_link(__MODULE__, cells)

  @impl true
  def init(definitions) do
    inputs = Enum.filter(definitions, &match?({:input, _, _}, &1))
    outputs = Enum.filter(definitions, &match?({:output, _, _, _}, &1))

    cells =
      Enum.reduce(inputs, %{}, fn {:input, name, value}, cells ->
        Map.put(cells, name, %{type: :input, value: value})
      end)

    {cells, order} =
      Enum.reduce(outputs, {cells, []}, fn {:output, name, dependencies, function},
                                           {cells, order} ->
        value = evaluate(dependencies, function, cells)

        cell = %{
          type: :output,
          value: value,
          dependencies: dependencies,
          function: function,
          callbacks: []
        }

        {Map.put(cells, name, cell), order ++ [name]}
      end)

    {:ok, %{cells: cells, output_order: order}}
  end

  @impl true
  def handle_call({:get_value, name}, _from, state) do
    {:reply, state.cells[name].value, state}
  end

  def handle_call({:set_value, name, value}, _from, state) do
    old_values = Map.new(state.cells, fn {cell_name, cell} -> {cell_name, cell.value} end)
    cells = Map.update!(state.cells, name, &Map.put(&1, :value, value))
    cells = stabilize(cells, state.output_order, length(state.output_order) + 1)

    state.output_order
    |> Enum.each(fn output_name ->
      cell = cells[output_name]

      if old_values[output_name] != cell.value do
        Enum.each(cell.callbacks, fn {callback_name, callback} ->
          callback.(callback_name, cell.value)
        end)
      end
    end)

    {:reply, :ok, %{state | cells: cells}}
  end

  def handle_call({:add_callback, name, callback_name, callback}, _from, state) do
    cells =
      Map.update!(state.cells, name, fn cell ->
        Map.update!(cell, :callbacks, &put_callback(&1, callback_name, callback))
      end)

    {:reply, :ok, %{state | cells: cells}}
  end

  def handle_call({:remove_callback, name, callback_name}, _from, state) do
    cells =
      Map.update!(state.cells, name, fn cell ->
        Map.update!(
          cell,
          :callbacks,
          &Enum.reject(&1, fn {key, _fun} -> key == callback_name end)
        )
      end)

    {:reply, :ok, %{state | cells: cells}}
  end

  defp stabilize(cells, _order, 0), do: cells

  defp stabilize(cells, order, passes_left) do
    {cells, changed?} =
      Enum.reduce(order, {cells, false}, fn name, {cells, changed?} ->
        cell = cells[name]
        value = evaluate(cell.dependencies, cell.function, cells)
        {put_in(cells[name].value, value), changed? or value != cell.value}
      end)

    if changed?, do: stabilize(cells, order, passes_left - 1), else: cells
  end

  defp evaluate(dependencies, function, cells) do
    arguments = Enum.map(dependencies, &cells[&1].value)
    apply(function, arguments)
  end

  defp put_callback(callbacks, name, callback) do
    if Enum.any?(callbacks, fn {current_name, _fun} -> current_name == name end) do
      Enum.map(callbacks, fn
        {^name, _old_callback} -> {name, callback}
        existing -> existing
      end)
    else
      callbacks ++ [{name, callback}]
    end
  end
end
