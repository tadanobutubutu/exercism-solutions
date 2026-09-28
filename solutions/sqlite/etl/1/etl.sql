-- Schema: CREATE TABLE "etl" ("input" TEXT, "result" TEXT);
-- Task: update the etl table and set the result based on the input field. The keys in the result object must be sorted alphabetically.
UPDATE etl
SET result = (
  SELECT json_group_object(letter, score)
  FROM (
    SELECT
      lower(letters.value) AS letter,
      CAST(groups.key AS INTEGER) AS score
    FROM json_each(etl.input) AS groups,
         json_each(groups.value) AS letters
    ORDER BY lower(letters.value)
  )
);
