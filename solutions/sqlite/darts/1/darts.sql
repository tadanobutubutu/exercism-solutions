-- Schema: CREATE TABLE "darts" ("x" REAL, "y" REAL, score INTEGER);
-- Task: update the darts table and set the score based on the x and y values.
UPDATE darts
SET score = CASE
  WHEN x * x + y * y <= 1 THEN 10
  WHEN x * x + y * y <= 25 THEN 5
  WHEN x * x + y * y <= 100 THEN 1
  ELSE 0
END;
