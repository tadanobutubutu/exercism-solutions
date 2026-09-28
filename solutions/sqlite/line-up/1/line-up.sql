-- Schema:
-- CREATE TABLE "line-up" (
--   name   TEXT    NOT NULL,
--   number INTEGER NOT NULL,
--   result TEXT
-- );
--
-- Task: Update the line-up table and set the result column based on the name and the number.
UPDATE "line-up"
SET result = name || ', you are the ' || number ||
  CASE
    WHEN number % 100 BETWEEN 11 AND 13 THEN 'th'
    WHEN number % 10 = 1 THEN 'st'
    WHEN number % 10 = 2 THEN 'nd'
    WHEN number % 10 = 3 THEN 'rd'
    ELSE 'th'
  END || ' customer we serve today. Thank you!';
