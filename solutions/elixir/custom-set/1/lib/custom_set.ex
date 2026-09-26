defmodule CustomSet do
  defstruct map: MapSet.new()

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %__MODULE__{map: MapSet.new(enumerable)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    MapSet.size(custom_set.map) == 0
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    MapSet.member?(custom_set.map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    MapSet.subset?(custom_set_1.map, custom_set_2.map)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    MapSet.disjoint?(custom_set_1.map, custom_set_2.map)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    MapSet.equal?(custom_set_1.map, custom_set_2.map)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %{custom_set | map: MapSet.put(custom_set.map, element)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    %__MODULE__{map: MapSet.intersection(custom_set_1.map, custom_set_2.map)}
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    %__MODULE__{map: MapSet.difference(custom_set_1.map, custom_set_2.map)}
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    %__MODULE__{map: MapSet.union(custom_set_1.map, custom_set_2.map)}
  end
end
