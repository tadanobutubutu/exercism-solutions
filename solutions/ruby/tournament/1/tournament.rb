class Tournament
  def self.tally(input)
    scores = Hash.new { |h, k| h[k] = { w: 0, d: 0, l: 0 } }

    input.strip.split("\n").each do |line|
      team1, team2, result = line.split(';')
      case result
      when 'win'
        scores[team1][:w] += 1
        scores[team2][:l] += 1
      when 'loss'
        scores[team1][:l] += 1
        scores[team2][:w] += 1
      when 'draw'
        scores[team1][:d] += 1
        scores[team2][:d] += 1
      end
    end

    sorted_scores = scores.map do |team, s|
      mp = s[:w] + s[:d] + s[:l]
      p = s[:w] * 3 + s[:d]
      { team: team, mp: mp, w: s[:w], d: s[:d], l: s[:l], p: p }
    end.sort_by { |s| [-s[:p], s[:team]] }

    output = "Team                           | MP |  W |  D |  L |  P\n"
    sorted_scores.each do |s|
      output += sprintf("%-30s | %2d | %2d | %2d | %2d | %2d\n", s[:team], s[:mp], s[:w], s[:d], s[:l], s[:p])
    end
    output
  end
end
