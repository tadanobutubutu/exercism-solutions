# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> %{next_id: 1, registrations: []} end, opts)

  def list_registrations(pid) do
    Agent.get(pid, & &1.registrations)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{plot_id: state.next_id, registered_to: register_to}
      updated = %{state | next_id: state.next_id + 1, registrations: state.registrations ++ [plot]}
      {plot, updated}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{state | registrations: Enum.reject(state.registrations, &(&1.plot_id == plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state.registrations, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
    end)
  end
end
