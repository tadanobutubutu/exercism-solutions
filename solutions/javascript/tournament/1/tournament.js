//
// This is only a SKELETON file for the 'Tournament' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const header = 'Team                           | MP |  W |  D |  L |  P';

export const tournamentTally = (results) => {
  const teams = new Map();
  const getTeam = (name) => {
    if (!teams.has(name)) {
      teams.set(name, { name, played: 0, won: 0, drawn: 0, lost: 0, points: 0 });
    }
    return teams.get(name);
  };

  for (const line of results.split('\n').filter(Boolean)) {
    const [homeName, awayName, result] = line.split(';');
    const home = getTeam(homeName);
    const away = getTeam(awayName);
    home.played += 1;
    away.played += 1;

    if (result === 'win') {
      home.won += 1;
      home.points += 3;
      away.lost += 1;
    } else if (result === 'loss') {
      home.lost += 1;
      away.won += 1;
      away.points += 3;
    } else if (result === 'draw') {
      home.drawn += 1;
      away.drawn += 1;
      home.points += 1;
      away.points += 1;
    }
  }

  const rows = [...teams.values()]
    .sort((a, b) => b.points - a.points || a.name.localeCompare(b.name))
    .map(({ name, played, won, drawn, lost, points }) =>
      `${name.padEnd(31)}| ${String(played).padStart(2)} | ${String(won).padStart(2)} | ${String(drawn).padStart(2)} | ${String(lost).padStart(2)} | ${String(points).padStart(2)}`);

  return [header, ...rows].join('\n');
};
