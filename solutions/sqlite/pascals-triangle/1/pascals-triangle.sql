WITH RECURSIVE
source AS (
  SELECT rowid AS id, input FROM "pascals-triangle"
),
coefficients(id, row_count, row_no, column_no, value) AS (
  SELECT id, input, 1, 1, 1
    FROM source
   WHERE input > 0
  UNION ALL
  SELECT id,
         row_count,
         CASE WHEN column_no < row_no THEN row_no ELSE row_no + 1 END,
         CASE WHEN column_no < row_no THEN column_no + 1 ELSE 1 END,
         CASE WHEN column_no < row_no
              THEN value * (row_no - column_no) / column_no
              ELSE 1 END
    FROM coefficients
   WHERE row_no < row_count OR column_no < row_no
),
rows_text AS (
  SELECT DISTINCT id, row_no,
         (SELECT group_concat(value, ' ')
            FROM (SELECT value FROM coefficients AS c
                   WHERE c.id = a.id AND c.row_no = a.row_no
                   ORDER BY column_no)
         ) AS text
    FROM coefficients AS a
),
answers AS (
  SELECT source.id,
         COALESCE((SELECT group_concat(text, char(10))
                     FROM (SELECT text FROM rows_text AS r
                            WHERE r.id = source.id
                            ORDER BY row_no)), '') AS result
    FROM source
)
UPDATE "pascals-triangle"
   SET result = answers.result
  FROM answers
 WHERE "pascals-triangle".rowid = answers.id;
