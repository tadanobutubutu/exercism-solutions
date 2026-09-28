-- Schema:
-- CREATE TABLE matrix (
--     string   TEXT    NOT NULL,  -- the matrix as a plain string
--     property TEXT    NOT NULL,  -- either "row" or "column" which we want to extract
--     "index"  INTEGER NOT NULL,  -- the row or column index to extract
--     result   TEXT               -- json array of integers containing the row or column at the specified index
-- );
--
-- Task: update the matrix table and set the result based on the property, string and index.
WITH RECURSIVE lines(id, row_number, rest, line) AS (
  SELECT rowid, 0, string || char(10), ''
  FROM matrix
  UNION ALL
  SELECT id,
         row_number + 1,
         substr(rest, instr(rest, char(10)) + 1),
         substr(rest, 1, instr(rest, char(10)) - 1)
  FROM lines
  WHERE rest <> ''
), words(id, row_number, column_number, rest, word) AS (
  SELECT id, row_number, 0, line || ' ', ''
  FROM lines
  WHERE row_number > 0
  UNION ALL
  SELECT id,
         row_number,
         column_number + 1,
         substr(rest, instr(rest, ' ') + 1),
         substr(rest, 1, instr(rest, ' ') - 1)
  FROM words
  WHERE rest <> ''
), selected AS (
  SELECT
    matrix.rowid AS id,
    words.row_number,
    words.column_number,
    CAST(words.word AS INTEGER) AS value
  FROM matrix
  JOIN words ON words.id = matrix.rowid
  WHERE words.column_number > 0
    AND ((matrix.property = 'row' AND words.row_number = matrix."index")
      OR (matrix.property = 'column' AND words.column_number = matrix."index"))
), results AS (
  SELECT id, json_group_array(value) AS result
  FROM (
    SELECT id, row_number, column_number, value
    FROM selected
    ORDER BY id, row_number, column_number
  )
  GROUP BY id
)
UPDATE matrix
SET result = (SELECT result FROM results WHERE results.id = matrix.rowid);
