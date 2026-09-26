defmodule Zipper do
  defstruct [:focus, trail: []]

  @type trail_entry :: {:left, any, BinTree.t()} | {:right, any, BinTree.t()}
  @type t :: %__MODULE__{focus: BinTree.t(), trail: [trail_entry()]}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %__MODULE__{focus: bin_tree, trail: []}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper), do: zipper |> root() |> Map.fetch!(:focus)

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper), do: zipper.focus.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%__MODULE__{focus: %BinTree{left: nil}}), do: nil

  def left(%__MODULE__{focus: focus, trail: trail}) do
    %__MODULE__{
      focus: focus.left,
      trail: [{:left, focus.value, focus.right} | trail]
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%__MODULE__{focus: %BinTree{right: nil}}), do: nil

  def right(%__MODULE__{focus: focus, trail: trail}) do
    %__MODULE__{
      focus: focus.right,
      trail: [{:right, focus.value, focus.left} | trail]
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%__MODULE__{trail: []}), do: nil

  def up(%__MODULE__{focus: focus, trail: [{:left, parent_value, right} | trail]}) do
    %__MODULE__{focus: %BinTree{value: parent_value, left: focus, right: right}, trail: trail}
  end

  def up(%__MODULE__{focus: focus, trail: [{:right, parent_value, left} | trail]}) do
    %__MODULE__{focus: %BinTree{value: parent_value, left: left, right: focus}, trail: trail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%__MODULE__{focus: focus} = zipper, value),
    do: %{zipper | focus: %{focus | value: value}}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(%__MODULE__{focus: focus} = zipper, left),
    do: %{zipper | focus: %{focus | left: left}}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(%__MODULE__{focus: focus} = zipper, right),
    do: %{zipper | focus: %{focus | right: right}}

  defp root(%__MODULE__{trail: []} = zipper), do: zipper
  defp root(%__MODULE__{} = zipper), do: zipper |> up() |> root()
end
