type Standing = { played: number; wins: number; draws: number; losses: number; points: number }

const header = 'Team                           | MP |  W |  D |  L |  P'

export class Tournament {
  public tally(input: string): string {
    const standings = new Map<string, Standing>()
    const get = (team: string): Standing => {
      let standing = standings.get(team)
      if (!standing) {
        standing = { played: 0, wins: 0, draws: 0, losses: 0, points: 0 }
        standings.set(team, standing)
      }
      return standing
    }

    for (const line of input.split('\n')) {
      if (!line) continue
      const [first, second, result] = line.split(';')
      if (!first || !second || !result) continue
      const firstStats = get(first)
      const secondStats = get(second)
      firstStats.played++
      secondStats.played++

      if (result === 'draw') {
        firstStats.draws++
        secondStats.draws++
        firstStats.points++
        secondStats.points++
      } else {
        const winner = result === 'win' ? firstStats : secondStats
        const loser = result === 'win' ? secondStats : firstStats
        winner.wins++
        winner.points += 3
        loser.losses++
      }
    }

    const rows = [...standings.entries()]
      .sort(([teamA, statsA], [teamB, statsB]) =>
        statsB.points - statsA.points || teamA.localeCompare(teamB)
      )
      .map(([team, stats]) =>
        `${team.padEnd(31)}| ${String(stats.played).padStart(2)} | ` +
        `${String(stats.wins).padStart(2)} | ${String(stats.draws).padStart(2)} | ` +
        `${String(stats.losses).padStart(2)} | ${String(stats.points).padStart(2)}`
      )
    return [header, ...rows].join('\n')
  }
}
