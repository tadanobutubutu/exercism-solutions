WITH RECURSIVE
source AS (
  SELECT rowid AS id, input FROM tournament
),
lines(id, input, line_no, remaining, line) AS (
  SELECT id,
         input,
         1,
         CASE WHEN instr(input, char(10)) = 0 THEN substr(input, 1, 0)
              ELSE substr(input, instr(input, char(10)) + 1) END,
         substr(input || char(10), 1, instr(input || char(10), char(10)) - 1)
    FROM source
  UNION ALL
  SELECT id,
         input,
         line_no + 1,
         CASE WHEN instr(remaining, char(10)) = 0 THEN substr(remaining, 1, 0)
              ELSE substr(remaining, instr(remaining, char(10)) + 1) END,
         substr(remaining || char(10), 1, instr(remaining || char(10), char(10)) - 1)
    FROM lines
   WHERE remaining <> ''
),
games AS (
  SELECT id,
         line_no,
         substr(line, 1, instr(line, ';') - 1) AS team_one,
         substr(substr(line, instr(line, ';') + 1),
                1,
                instr(substr(line, instr(line, ';') + 1), ';') - 1) AS team_two,
         substr(substr(line, instr(line, ';') + 1),
                instr(substr(line, instr(line, ';') + 1), ';') + 1) AS outcome
    FROM lines
   WHERE line <> ''
),
team_results(id, team, played, won, drawn, lost, points) AS (
  SELECT id,
         team_one,
         1,
         CASE outcome WHEN 'win' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'draw' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'loss' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'win' THEN 3 WHEN 'draw' THEN 1 ELSE 0 END
    FROM games
  UNION ALL
  SELECT id,
         team_two,
         1,
         CASE outcome WHEN 'loss' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'draw' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'win' THEN 1 ELSE 0 END,
         CASE outcome WHEN 'loss' THEN 3 WHEN 'draw' THEN 1 ELSE 0 END
    FROM games
),
team_stats AS (
  SELECT id, team,
         SUM(played) AS played,
         SUM(won) AS won,
         SUM(drawn) AS drawn,
         SUM(lost) AS lost,
         SUM(points) AS points
    FROM team_results
   GROUP BY id, team
),
formatted AS (
  SELECT id, team, points,
         printf('%-30s | %2d | %2d | %2d | %2d | %2d',
                team, played, won, drawn, lost, points) AS line
    FROM team_stats
),
answers AS (
  SELECT s.id,
         'Team                           | MP |  W |  D |  L |  P' ||
         CASE WHEN EXISTS (SELECT 1 FROM formatted f WHERE f.id = s.id)
              THEN char(10) || COALESCE((
                SELECT group_concat(line, char(10))
                  FROM (SELECT line FROM formatted AS f
                         WHERE f.id = s.id
                         ORDER BY points DESC, team)
              ), '')
              ELSE '' END AS result
    FROM source AS s
)
UPDATE tournament
   SET result = answers.result
  FROM answers
 WHERE tournament.rowid = answers.id;
