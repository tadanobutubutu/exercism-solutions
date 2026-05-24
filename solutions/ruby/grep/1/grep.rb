class Grep
  def self.grep(pattern, flags, files)
    results = []
    multiple = files.length > 1
    print_files = flags.include?('-l')
    print_numbers = flags.include?('-n')
    case_insensitive = flags.include?('-i')
    exact_match = flags.include?('-x')
    invert = flags.include?('-v')

    files.each do |file|
      lines = File.readlines(file, chomp: true)
      file_matched = false
      lines.each_with_index do |line, idx|
        test_line = case_insensitive ? line.downcase : line
        test_pattern = case_insensitive ? pattern.downcase : pattern
        matched = if exact_match
                    test_line == test_pattern
                  else
                    test_line.include?(test_pattern)
                  end
        matched = !matched if invert

        next unless matched

        if print_files
          file_matched = true
        elsif multiple
          entry = "#{file}:#{print_numbers ? "#{idx + 1}:" : ''}#{line}"
          results << entry
        else
          entry = "#{print_numbers ? "#{idx + 1}:" : ''}#{line}"
          results << entry
        end
      end
      results << file if print_files && file_matched
    end
    results.join("\n")
  end
end
