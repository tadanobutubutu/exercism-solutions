-- Schema:
-- CREATE TABLE "square-root" (
--     radicand INTEGER NOT NULL,
--     result   INTEGER
-- );
--
-- Task: update the square-root table and set the result based on the radicand.
WITH RECURSIVE candidates(id, radicand, root) AS (
  SELECT rowid, radicand, 1 FROM "square-root"
  UNION ALL
  SELECT id, radicand, root + 1
  FROM candidates
  WHERE (root + 1) * (root + 1) <= radicand
)
UPDATE "square-root"
SET result = (
  SELECT MAX(root)
  FROM candidates
  WHERE candidates.id = "square-root".rowid
);
