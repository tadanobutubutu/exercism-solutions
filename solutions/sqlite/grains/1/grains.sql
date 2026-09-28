-- Schema: CREATE TABLE "grains" ("task" TEXT, "square" INT, "result" INT);
-- Task: update the grains table and set the result based on the task (and square fields).
UPDATE grains
SET result = CASE task
  WHEN 'single-square' THEN CASE
    WHEN square = 64 THEN 9.223372036854775808e18
    WHEN square BETWEEN 1 AND 63 THEN 1 << (square - 1)
    ELSE NULL
  END
  WHEN 'total' THEN 1.8446744073709551615e19
  ELSE NULL
END;
