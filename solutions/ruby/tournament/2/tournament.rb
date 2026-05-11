class Tournament
  def self.tally(input)
    return "Team                           | MP |  W |  D |  L |  P\n" if input.strip.empty?
    
    teams = {}
    
    input.each_line do |line|
      line = line.strip
      next if line.empty?
      
      home_team, away_team, result = line.split(';')
      
      teams[home_team] ||= { played: 0, won: 0, drawn: 0, lost: 0, points: 0 }
      teams[away_team] ||= { played: 0, won: 0, drawn: 0, lost: 0, points: 0 }
      
      teams[home_team][:played] += 1
      teams[away_team][:played] += 1
      
      case result
      when 'win'
        teams[home_team][:won] += 1
        teams[home_team][:points] += 3
        teams[away_team][:lost] += 1
      when 'loss'
        teams[home_team][:lost] += 1
        teams[away_team][:won] += 1
        teams[away_team][:points] += 3
      when 'draw'
        teams[home_team][:drawn] += 1
        teams[home_team][:points] += 1
        teams[away_team][:drawn] += 1
        teams[away_team][:points] += 1
      end
    end
    
    # Sort teams by points (descending), then by name (ascending)
    sorted_teams = teams.sort_by { |name, stats| [-stats[:points], name] }
    
    # Build header
    result = "Team                           | MP |  W |  D |  L |  P\n"
    
    # Build team rows
    sorted_teams.each do |name, stats|
      row = format("%-30s | %2d | %2d | %2d | %2d | %2d\n",
                   name,
                   stats[:played],
                   stats[:won],
                   stats[:drawn],
                   stats[:lost],
                   stats[:points])
      result += row
    end
    
    result
  end
end
