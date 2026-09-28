-- Schema: CREATE TABLE IF NOT EXISTS "all-your-base" (
--           input_base  INTEGER NOT NULL,
--           digits      TEXT    NOT NULL,  -- json array
--           output_base INTEGER NOT NULL,
--           result      TEXT               -- json object
--         );
-- Task: update the all-your-base table and set the result based on converting
--       digits from input_base to output_base.
--       * the digits column contains a JSON-encoded list of integers.
--       * the result column should contain JSON-encoded data: an
--         object with the digits as integers or a descripition of any errors.
WITH RECURSIVE valid_rows(id, input_base, digits, output_base, position, value) AS (
  SELECT
    rowid,
    input_base,
    digits,
    output_base,
    0,
    0
  FROM "all-your-base"
  WHERE input_base >= 2
    AND output_base >= 2
    AND NOT EXISTS (
      SELECT 1
      FROM json_each("all-your-base".digits)
      WHERE CAST(json_each.value AS INTEGER) < 0
         OR CAST(json_each.value AS INTEGER) >= "all-your-base".input_base
    )
  UNION ALL
  SELECT
    id,
    input_base,
    digits,
    output_base,
    position + 1,
    value * input_base + CAST(json_extract(digits, '$[' || position || ']') AS INTEGER)
  FROM valid_rows
  WHERE position < json_array_length(digits)
), values_to_convert AS (
  SELECT id, output_base, value
  FROM valid_rows
  WHERE position = json_array_length(digits)
), output_digits(id, output_base, value, digits) AS (
  SELECT id, output_base, value, json('[]')
  FROM values_to_convert
  UNION ALL
  SELECT
    id,
    output_base,
    value / output_base,
    json_insert(digits, '$[#]', value % output_base)
  FROM output_digits
  WHERE value > 0
), converted AS (
  SELECT id, digits
  FROM output_digits
  WHERE value = 0
), normalized AS (
  SELECT
    converted.id,
    CASE
      WHEN converted.digits = '[]' THEN '[0]'
      ELSE (
        SELECT json_group_array(CAST(ordered.value AS INTEGER))
        FROM (
          SELECT value
          FROM json_each(converted.digits)
          ORDER BY CAST(key AS INTEGER) DESC
        ) AS ordered
      )
    END AS digits
  FROM converted
)
UPDATE "all-your-base"
SET result = CASE
  WHEN input_base < 2 THEN json_object('error', 'input base must be >= 2')
  WHEN output_base < 2 THEN json_object('error', 'output base must be >= 2')
  WHEN EXISTS (
    SELECT 1
    FROM json_each("all-your-base".digits)
    WHERE CAST(json_each.value AS INTEGER) < 0
       OR CAST(json_each.value AS INTEGER) >= "all-your-base".input_base
  ) THEN json_object('error', 'all digits must satisfy 0 <= d < input base')
  ELSE json_object(
    'digits',
    json(normalized.digits)
  )
END
FROM normalized
WHERE "all-your-base".rowid = normalized.id;

UPDATE "all-your-base"
SET result = CASE
  WHEN input_base < 2 THEN json_object('error', 'input base must be >= 2')
  WHEN output_base < 2 THEN json_object('error', 'output base must be >= 2')
  WHEN EXISTS (
    SELECT 1 FROM json_each("all-your-base".digits)
    WHERE CAST(json_each.value AS INTEGER) < 0
       OR CAST(json_each.value AS INTEGER) >= "all-your-base".input_base
  ) THEN json_object('error', 'all digits must satisfy 0 <= d < input base')
END
WHERE input_base < 2
   OR output_base < 2
   OR EXISTS (
     SELECT 1 FROM json_each("all-your-base".digits)
     WHERE CAST(json_each.value AS INTEGER) < 0
        OR CAST(json_each.value AS INTEGER) >= "all-your-base".input_base
   );
