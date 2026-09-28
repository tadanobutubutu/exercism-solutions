-- Schema:
-- CREATE TABLE "perfect-numbers" (
--   number INTEGER NOT NULL,
--   result TEXT,
--   error  TEXT
-- );
--
-- Task: update the perfect-numbers table and set the result or the error columns based on number.
WITH RECURSIVE divisors(id, number, divisor) AS (
  SELECT rowid, number, 1
  FROM "perfect-numbers"
  WHERE number > 0
  UNION ALL
  SELECT id, number, divisor + 1
  FROM divisors
  WHERE (divisor + 1) * (divisor + 1) <= number
), aliquot_sums AS (
  SELECT
    id,
    SUM(
      CASE
        WHEN number % divisor = 0 AND divisor < number THEN divisor
        ELSE 0
      END +
      CASE
        WHEN number % divisor = 0
          AND number / divisor <> divisor
          AND number / divisor < number
          THEN number / divisor
        ELSE 0
      END
    ) AS aliquot_sum
  FROM divisors
  GROUP BY id
)
UPDATE "perfect-numbers"
SET
  result = CASE
    WHEN "perfect-numbers".number > 0 AND aliquot_sums.aliquot_sum = "perfect-numbers".number THEN 'perfect'
    WHEN "perfect-numbers".number > 0 AND aliquot_sums.aliquot_sum > "perfect-numbers".number THEN 'abundant'
    WHEN "perfect-numbers".number > 0 THEN 'deficient'
    ELSE NULL
  END,
  error = CASE
    WHEN "perfect-numbers".number <= 0 THEN 'Classification is only possible for positive integers.'
    ELSE NULL
  END
FROM aliquot_sums
WHERE "perfect-numbers".rowid = aliquot_sums.id;

UPDATE "perfect-numbers"
SET error = 'Classification is only possible for positive integers.'
WHERE number <= 0;
