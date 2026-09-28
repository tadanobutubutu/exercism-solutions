-- Schema: CREATE TABLE pangram (sentence TEXT NOT NULL, result BOOLEAN);
-- Task: update pangram table and set result based on sentence.
WITH RECURSIVE letters(code) AS (
  SELECT 97
  UNION ALL
  SELECT code + 1 FROM letters WHERE code < 122
)
UPDATE pangram
SET result = NOT EXISTS (
  SELECT 1
  FROM letters
  WHERE instr(lower(pangram.sentence), char(letters.code)) = 0
);
