-- Schema:
-- CREATE TABLE "binary-search" (
--   array  TEXT    NOT NULL,    -- json array
--   value  INTEGER NOT NULL,
--   result INTEGER         ,
--   error  TEXT
-- );
--
-- Task: update the binary-search table and set the result or the error columns based on the array and the value.
WITH RECURSIVE search(id, array, target, low, high, step, found) AS (
  SELECT rowid, array, value, 0, json_array_length(array) - 1, 0, NULL
  FROM "binary-search"
  UNION ALL
  SELECT
    id,
    array,
    target,
    CASE
      WHEN CAST(json_extract(array, '$[' || ((low + high) / 2) || ']') AS INTEGER) < target
        THEN ((low + high) / 2) + 1
      ELSE low
    END,
    CASE
      WHEN CAST(json_extract(array, '$[' || ((low + high) / 2) || ']') AS INTEGER) > target
        THEN ((low + high) / 2) - 1
      ELSE high
    END,
    step + 1,
    CASE
      WHEN CAST(json_extract(array, '$[' || ((low + high) / 2) || ']') AS INTEGER) = target
        THEN (low + high) / 2
      ELSE NULL
    END
  FROM search
  WHERE low <= high AND found IS NULL
), final_results AS (
  SELECT id, found
  FROM search
  WHERE step = (SELECT MAX(other.step) FROM search AS other WHERE other.id = search.id)
)
UPDATE "binary-search"
SET
  result = (SELECT found FROM final_results WHERE final_results.id = "binary-search".rowid),
  error = CASE
    WHEN (SELECT found FROM final_results WHERE final_results.id = "binary-search".rowid) IS NULL
      THEN 'value not in array'
    ELSE NULL
  END;
