-- Schema:
-- CREATE TABLE "crypto-square" (
--   plaintext TEXT NOT NULL,
--   result    TEXT
-- );
--
-- Task: update the crypto-square table and set the result column based on the plaintext.
WITH RECURSIVE scanned(id, plaintext, position, normalized) AS (
  SELECT rowid, plaintext, 1, ''
  FROM "crypto-square"
  UNION ALL
  SELECT
    id,
    plaintext,
    position + 1,
    normalized || CASE
      WHEN unicode(lower(substr(plaintext, position, 1))) BETWEEN 97 AND 122
        OR substr(plaintext, position, 1) GLOB '[0-9]'
      THEN lower(substr(plaintext, position, 1))
      ELSE ''
    END
  FROM scanned
  WHERE position <= length(plaintext)
), normalized_text(id, text, length) AS (
  SELECT id, normalized, length(normalized)
  FROM scanned
  WHERE position > length(plaintext)
), possible_columns(id, text, length, columns) AS (
  SELECT id, text, length, 1
  FROM normalized_text
  WHERE length > 0
  UNION ALL
  SELECT id, text, length, columns + 1
  FROM possible_columns
  WHERE columns * columns < length
), dimensions AS (
  SELECT
    normalized_text.id,
    normalized_text.text,
    normalized_text.length,
    COALESCE(MAX(possible_columns.columns), 0) AS columns,
    CASE
      WHEN normalized_text.length = 0 THEN 0
      ELSE (normalized_text.length + MAX(possible_columns.columns) - 1) / MAX(possible_columns.columns)
    END AS rows
  FROM normalized_text
  LEFT JOIN possible_columns USING (id)
  GROUP BY normalized_text.id, normalized_text.text, normalized_text.length
), grid(id, text, length, columns, rows, column_number, row_number) AS (
  SELECT id, text, length, columns, rows, 1, 1
  FROM dimensions
  WHERE columns > 0
  UNION ALL
  SELECT
    id,
    text,
    length,
    columns,
    rows,
    CASE WHEN row_number = rows THEN column_number + 1 ELSE column_number END,
    CASE WHEN row_number = rows THEN 1 ELSE row_number + 1 END
  FROM grid
  WHERE column_number < columns OR row_number < rows
), cells AS (
  SELECT
    id,
    column_number,
    row_number,
    CASE
      WHEN (row_number - 1) * columns + column_number <= length
        THEN substr(text, (row_number - 1) * columns + column_number, 1)
      ELSE ' '
    END AS character
  FROM grid
), chunks AS (
  SELECT id, column_number, group_concat(character, '') AS chunk
  FROM (
    SELECT id, column_number, row_number, character
    FROM cells
    ORDER BY id, column_number, row_number
  )
  GROUP BY id, column_number
), encoded AS (
  SELECT id, group_concat(chunk, ' ') AS result
  FROM (
    SELECT id, column_number, chunk
    FROM chunks
    ORDER BY id, column_number
  )
  GROUP BY id
)
UPDATE "crypto-square"
SET result = COALESCE(
  (SELECT result FROM encoded WHERE encoded.id = "crypto-square".rowid),
  ''
);
