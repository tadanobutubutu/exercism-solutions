defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    %{grades: %{}, students: MapSet.new()}
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if MapSet.member?(school.students, name) do
      {:error, school}
    else
      students = MapSet.put(school.students, name)
      grade_students = Map.get(school.grades, grade, []) |> then(&Enum.sort([name | &1]))
      grades = Map.put(school.grades, grade, grade_students)
      {:ok, %{school | grades: grades, students: students}}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    Map.get(school.grades, grade, [])
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school.grades
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.flat_map(&elem(&1, 1))
  end
end
