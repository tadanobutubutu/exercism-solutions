-- Schema:
-- CREATE TABLE "sum-of-multiples" (
--     factors TEXT    NOT NULL,     -- json array of integers
--     "limit" INTEGER NOT NULL,
--     result  INTEGER
-- );
--
-- Task: update the "sum-of-multiples" table based on its factors and limit.
WITH RECURSIVE multiples(id, factor, value, "limit") AS (
  SELECT
    "sum-of-multiples".rowid,
    CAST(json_each.value AS INTEGER),
    CAST(json_each.value AS INTEGER),
    "sum-of-multiples"."limit"
  FROM "sum-of-multiples",
       json_each("sum-of-multiples".factors)
  WHERE CAST(json_each.value AS INTEGER) > 0
    AND CAST(json_each.value AS INTEGER) < "sum-of-multiples"."limit"
  UNION ALL
  SELECT id, factor, value + factor, "limit"
  FROM multiples
  WHERE value + factor < "limit"
), totals AS (
  SELECT id, SUM(DISTINCT value) AS total
  FROM multiples
  GROUP BY id
)
UPDATE "sum-of-multiples"
SET result = COALESCE(
  (SELECT total FROM totals WHERE totals.id = "sum-of-multiples".rowid),
  0
);
