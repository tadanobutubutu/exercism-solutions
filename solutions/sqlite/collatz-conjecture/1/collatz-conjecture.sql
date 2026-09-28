-- Schema: CREATE TABLE "collatz" ("number" INTEGER, "steps" INTEGER);
-- Task: update the collatz table and set the steps based on the number.
WITH RECURSIVE sequence(id, current, steps) AS (
  SELECT rowid, "number", 0
  FROM collatz
  UNION ALL
  SELECT
    id,
    CASE WHEN current % 2 = 0 THEN current / 2 ELSE 3 * current + 1 END,
    steps + 1
  FROM sequence
  WHERE current <> 1
)
UPDATE collatz
SET steps = (
  SELECT MAX(sequence.steps)
  FROM sequence
  WHERE sequence.id = collatz.rowid
);
