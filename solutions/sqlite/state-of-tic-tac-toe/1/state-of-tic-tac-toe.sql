WITH
boards AS (
  SELECT rowid AS id,
         replace(board, char(10), '') AS cells
    FROM "state-of-tic-tac-toe"
),
flags AS (
  SELECT id,
         cells,
         length(cells) - length(replace(cells, 'X', '')) AS x_count,
         length(cells) - length(replace(cells, 'O', '')) AS o_count,
         (
           (substr(cells,1,1)='X' AND substr(cells,2,1)='X' AND substr(cells,3,1)='X') OR
           (substr(cells,4,1)='X' AND substr(cells,5,1)='X' AND substr(cells,6,1)='X') OR
           (substr(cells,7,1)='X' AND substr(cells,8,1)='X' AND substr(cells,9,1)='X') OR
           (substr(cells,1,1)='X' AND substr(cells,4,1)='X' AND substr(cells,7,1)='X') OR
           (substr(cells,2,1)='X' AND substr(cells,5,1)='X' AND substr(cells,8,1)='X') OR
           (substr(cells,3,1)='X' AND substr(cells,6,1)='X' AND substr(cells,9,1)='X') OR
           (substr(cells,1,1)='X' AND substr(cells,5,1)='X' AND substr(cells,9,1)='X') OR
           (substr(cells,3,1)='X' AND substr(cells,5,1)='X' AND substr(cells,7,1)='X')
         ) AS x_wins,
         (
           (substr(cells,1,1)='O' AND substr(cells,2,1)='O' AND substr(cells,3,1)='O') OR
           (substr(cells,4,1)='O' AND substr(cells,5,1)='O' AND substr(cells,6,1)='O') OR
           (substr(cells,7,1)='O' AND substr(cells,8,1)='O' AND substr(cells,9,1)='O') OR
           (substr(cells,1,1)='O' AND substr(cells,4,1)='O' AND substr(cells,7,1)='O') OR
           (substr(cells,2,1)='O' AND substr(cells,5,1)='O' AND substr(cells,8,1)='O') OR
           (substr(cells,3,1)='O' AND substr(cells,6,1)='O' AND substr(cells,9,1)='O') OR
           (substr(cells,1,1)='O' AND substr(cells,5,1)='O' AND substr(cells,9,1)='O') OR
           (substr(cells,3,1)='O' AND substr(cells,5,1)='O' AND substr(cells,7,1)='O')
         ) AS o_wins
    FROM boards
),
answers AS (
  SELECT id,
         CASE
           WHEN x_wins OR o_wins THEN 'win'
           WHEN x_count < o_count THEN NULL
           WHEN x_count > o_count + 1 THEN NULL
           WHEN x_count + o_count = 9 THEN 'draw'
           ELSE 'ongoing'
         END AS result,
         CASE
           WHEN x_wins AND o_wins THEN 'Impossible board: game should have ended after the game was won'
           WHEN x_wins AND x_count <> o_count + 1 THEN 'Impossible board: game should have ended after the game was won'
           WHEN o_wins AND x_count <> o_count THEN 'Impossible board: game should have ended after the game was won'
           WHEN x_wins OR o_wins THEN NULL
           WHEN x_count < o_count THEN 'Wrong turn order: O started'
           WHEN x_count > o_count + 1 THEN 'Wrong turn order: X went twice'
           ELSE NULL
         END AS error
    FROM flags
)
UPDATE "state-of-tic-tac-toe"
   SET result = CASE WHEN answers.error IS NULL THEN answers.result ELSE NULL END,
       error = answers.error
  FROM answers
 WHERE "state-of-tic-tac-toe".rowid = answers.id;
