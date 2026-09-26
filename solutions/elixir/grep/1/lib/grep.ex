defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    case_insensitive? = "-i" in flags
    invert? = "-v" in flags
    whole_line? = "-x" in flags
    line_numbers? = "-n" in flags
    filenames_only? = "-l" in flags
    multiple_files? = length(files) > 1

    files
    |> Enum.flat_map(fn filename ->
      lines =
        filename
        |> File.read!()
        |> String.split("\n")
        |> drop_terminal_empty_line()

      matching_lines =
        lines
        |> Enum.with_index(1)
        |> Enum.filter(fn {line, _line_number} ->
          matched? = line_matches?(line, pattern, case_insensitive?, whole_line?)
          matched? != invert?
        end)

      cond do
        filenames_only? and matching_lines != [] ->
          [filename <> "\n"]

        filenames_only? ->
          []

        true ->
          Enum.map(matching_lines, fn {line, line_number} ->
            prefix = if multiple_files?, do: filename <> ":", else: ""

            prefix =
              if line_numbers?, do: prefix <> Integer.to_string(line_number) <> ":", else: prefix

            prefix <> line <> "\n"
          end)
      end
    end)
    |> IO.iodata_to_binary()
  end

  defp line_matches?(line, pattern, case_insensitive?, whole_line?) do
    {line, pattern} =
      if case_insensitive?,
        do: {String.downcase(line), String.downcase(pattern)},
        else: {line, pattern}

    if whole_line?, do: line == pattern, else: String.contains?(line, pattern)
  end

  defp drop_terminal_empty_line(lines) do
    if List.last(lines) == "", do: Enum.drop(lines, -1), else: lines
  end
end
