defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ [
        :alice,
        :bob,
        :charlie,
        :david,
        :eve,
        :fred,
        :ginny,
        :harriet,
        :ileana,
        :joseph,
        :kincaid,
        :larry
      ]) do
    [top_row, bottom_row] = String.split(info_string, "\n", trim: true)
    top = String.graphemes(top_row)
    bottom = String.graphemes(bottom_row)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Map.new(fn {student, index} ->
      offset = index * 2

      plants =
        [Enum.at(top, offset), Enum.at(top, offset + 1), Enum.at(bottom, offset), Enum.at(bottom, offset + 1)]
        |> Enum.reject(&is_nil/1)
        |> Enum.map(&decode_plant/1)

      {student, List.to_tuple(plants)}
    end)
  end

  defp decode_plant("G"), do: :grass
  defp decode_plant("C"), do: :clover
  defp decode_plant("R"), do: :radishes
  defp decode_plant("V"), do: :violets
end
