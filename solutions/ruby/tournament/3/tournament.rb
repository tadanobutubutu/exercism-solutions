class Tournament
  def self.tally(input)
    standings = Hash.new { |h, k| h[k] = { mp: 0, w: 0, d: 0, l: 0, p: 0 } }

    input.each_line do |line|
      line = line.strip
      next if line.empty?
      team1, team2, result = line.split(";")
      standings[team1][:mp] += 1
      standings[team2][:mp] += 1
      case result
      when "win"
        standings[team1][:w] += 1
        standings[team1][:p] += 3
        standings[team2][:l] += 1
      when "loss"
        standings[team2][:w] += 1
        standings[team2][:p] += 3
        standings[team1][:l] += 1
      when "draw"
        standings[team1][:d] += 1
        standings[team1][:p] += 1
        standings[team2][:d] += 1
        standings[team2][:p] += 1
      end
    end

    sorted = standings.sort_by { |name, stats| [-stats[:p], name] }

    output = "Team                           | MP |  W |  D |  L |  P\n"
    sorted.each do |name, stats|
      output += format("%-30s | %2d | %2d | %2d | %2d | %2d\n",
                       name, stats[:mp], stats[:w], stats[:d], stats[:l], stats[:p])
    end
    output
  end
end