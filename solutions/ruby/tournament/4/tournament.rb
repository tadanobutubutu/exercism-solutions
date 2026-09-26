class Tournament
  COLUMNS = %w[MP W D L P].freeze

  def self.tally(input)
    teams = Hash.new { |hash, name| hash[name] = { mp: 0, w: 0, d: 0, l: 0, p: 0 } }

    input.each_line do |line|
      home, away, result = line.strip.split(';')
      next unless home && away && result

      teams[home][:mp] += 1
      teams[away][:mp] += 1

      case result
      when 'win'
        teams[home][:w] += 1
        teams[home][:p] += 3
        teams[away][:l] += 1
      when 'loss'
        teams[home][:l] += 1
        teams[away][:w] += 1
        teams[away][:p] += 3
      when 'draw'
        [home, away].each do |name|
          teams[name][:d] += 1
          teams[name][:p] += 1
        end
      end
    end

    rows = teams.sort_by { |name, stats| [-stats[:p], name] }
    table = +"Team".ljust(31) + "| MP |  W |  D |  L |  P\n"
    rows.each do |name, stats|
      table << format("%-31s| %2d | %2d | %2d | %2d | %2d\n",
                      name, stats[:mp], stats[:w], stats[:d], stats[:l], stats[:p])
    end
    table
  end
end
