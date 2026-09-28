WITH RECURSIVE
source AS (
  SELECT rowid AS id, lines FROM transpose
),
rows(id, full_text, line_no, remaining, line_text) AS (
  SELECT id,
         lines,
         1,
         CASE WHEN instr(lines, char(10)) = 0 THEN ''
              ELSE substr(lines, instr(lines, char(10)) + 1) END,
         substr(lines || char(10), 1, instr(lines || char(10), char(10)) - 1)
    FROM source
   WHERE lines <> ''
  UNION ALL
  SELECT id,
         full_text,
         line_no + 1,
         substr(remaining || char(10), instr(remaining || char(10), char(10)) + 1, length(remaining || char(10)) - instr(remaining || char(10), char(10)) - 1),
         substr(remaining || char(10), 1, instr(remaining || char(10), char(10)) - 1)
    FROM rows
   WHERE remaining <> ''
),
columns(id, col_no, max_width) AS (
  SELECT id, 1, MAX(length(line_text)) FROM rows GROUP BY id
  UNION ALL
  SELECT id, col_no + 1, max_width
    FROM columns
   WHERE col_no < max_width
),
column_text(id, col_no, text) AS (
  SELECT c.id,
         c.col_no,
         (SELECT group_concat(piece, '')
            FROM (
              SELECT CASE WHEN length(r.line_text) >= c.col_no
                          THEN substr(r.line_text, c.col_no, 1)
                          ELSE ' ' END AS piece
                FROM rows AS r
               WHERE r.id = c.id
                 AND r.line_no <= (
                   SELECT MAX(r2.line_no)
                     FROM rows AS r2
                    WHERE r2.id = c.id
                      AND length(r2.line_text) >= c.col_no
                 )
               ORDER BY r.line_no
            )
         )
    FROM columns AS c
),
answers AS (
  SELECT s.id,
         COALESCE((SELECT group_concat(text, char(10))
                     FROM (SELECT text FROM column_text AS c
                            WHERE c.id = s.id
                            ORDER BY col_no)), '') AS result
    FROM source AS s
)
UPDATE transpose
   SET result = answers.result
  FROM answers
 WHERE transpose.rowid = answers.id;
