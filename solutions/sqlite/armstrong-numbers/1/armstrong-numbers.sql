-- Schema: CREATE TABLE "armstrong-numbers" ("number" INT, "result" BOOLEAN);
-- Task: update the armstrong-numbers table and set the result based on the number field.
WITH RECURSIVE digit_values(id, number, digit_count, position, digit) AS (
  SELECT
    rowid,
    "number",
    length(CAST("number" AS TEXT)),
    1,
    CAST(substr(CAST("number" AS TEXT), 1, 1) AS INTEGER)
  FROM "armstrong-numbers"
  UNION ALL
  SELECT
    id,
    number,
    digit_count,
    position + 1,
    CAST(substr(CAST(number AS TEXT), position + 1, 1) AS INTEGER)
  FROM digit_values
  WHERE position < digit_count
), powers(id, number, digit_count, position, digit, exponent, value) AS (
  SELECT id, number, digit_count, position, digit, 1, digit
  FROM digit_values
  UNION ALL
  SELECT id, number, digit_count, position, digit, exponent + 1, value * digit
  FROM powers
  WHERE exponent < digit_count
), totals AS (
  SELECT id, SUM(value) AS total
  FROM powers
  WHERE exponent = digit_count
  GROUP BY id
)
UPDATE "armstrong-numbers"
SET result = totals.total = "armstrong-numbers"."number"
FROM totals
WHERE "armstrong-numbers".rowid = totals.id;
