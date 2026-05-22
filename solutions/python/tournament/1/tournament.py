def tally(rows):
    stats = {}
    for row in rows:
        team1, team2, result = row.split(';')
        if team1 not in stats:
            stats[team1] = {'mp': 0, 'w': 0, 'd': 0, 'l': 0, 'p': 0}
        if team2 not in stats:
            stats[team2] = {'mp': 0, 'w': 0, 'd': 0, 'l': 0, 'p': 0}
        if result == 'win':
            stats[team1]['w'] += 1
            stats[team1]['p'] += 3
            stats[team2]['l'] += 1
        elif result == 'loss':
            stats[team2]['w'] += 1
            stats[team2]['p'] += 3
            stats[team1]['l'] += 1
        elif result == 'draw':
            stats[team1]['d'] += 1
            stats[team1]['p'] += 1
            stats[team2]['d'] += 1
            stats[team2]['p'] += 1
        stats[team1]['mp'] += 1
        stats[team2]['mp'] += 1
    teams = sorted(stats.items(), key=lambda x: (-x[1]['p'], x[0]))
    header = f"{'Team':31s}| MP |  W |  D |  L |  P"
    table = [header]
    for name, s in teams:
        table.append(
            f"{name:31s}| {s['mp']:>2d} | {s['w']:>2d} | {s['d']:>2d} | {s['l']:>2d} | {s['p']:>2d}"
        )
    return table
