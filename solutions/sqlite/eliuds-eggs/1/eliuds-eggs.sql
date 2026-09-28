-- Schema: CREATE TABLE "eliuds-eggs" ("number" INT, "result" INT);
-- Task: update the eliuds-eggs table and set the result based on the number field.
WITH RECURSIVE bit_counts(id, remaining, count) AS (
  SELECT rowid, "number", 0
  FROM "eliuds-eggs"
  UNION ALL
  SELECT id, remaining / 2, count + remaining % 2
  FROM bit_counts
  WHERE remaining > 0
)
UPDATE "eliuds-eggs"
SET result = (
  SELECT MAX(count)
  FROM bit_counts
  WHERE bit_counts.id = "eliuds-eggs".rowid
);
