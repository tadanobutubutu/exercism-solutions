WITH
cells AS (
  SELECT m.rowid AS id,
         CAST(r.key AS INTEGER) + 1 AS row_no,
         CAST(c.key AS INTEGER) + 1 AS col_no,
         CAST(c.value AS INTEGER) AS height
    FROM "saddle-points" AS m,
         json_each(m.matrix) AS r,
         json_each(r.value) AS c
),
row_maxima AS (
  SELECT id, row_no, MAX(height) AS height
    FROM cells
   GROUP BY id, row_no
),
column_minima AS (
  SELECT id, col_no, MIN(height) AS height
    FROM cells
   GROUP BY id, col_no
),
points AS (
  SELECT c.id, c.row_no, c.col_no,
         json_object('row', c.row_no, 'column', c.col_no) AS point
    FROM cells AS c
    JOIN row_maxima AS r ON r.id = c.id AND r.row_no = c.row_no AND r.height = c.height
    JOIN column_minima AS m ON m.id = c.id AND m.col_no = c.col_no AND m.height = c.height
),
answers AS (
  SELECT m.rowid AS id,
         COALESCE((SELECT json_group_array(json(point))
                     FROM (SELECT point FROM points AS p
                            WHERE p.id = m.rowid
                            ORDER BY row_no, col_no)), '[]') AS result
    FROM "saddle-points" AS m
)
UPDATE "saddle-points"
   SET result = answers.result
  FROM answers
 WHERE "saddle-points".rowid = answers.id;
