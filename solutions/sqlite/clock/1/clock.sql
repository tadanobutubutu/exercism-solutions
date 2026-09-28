-- Schema:
-- CREATE TABLE clock (
--   property TEXT NOT NULL,
--   input    TEXT NOT NULL,   -- json object
--   result   TEXT
-- );
--
-- Task: update the clock table and set the result column based on the input.
WITH parsed AS (
  SELECT
    rowid AS id,
    property,
    json_extract(input, '$.hour') AS hour,
    json_extract(input, '$.minute') AS minute,
    COALESCE(json_extract(input, '$.value'), 0) AS value,
    json_extract(input, '$.clock1.hour') AS hour1,
    json_extract(input, '$.clock1.minute') AS minute1,
    json_extract(input, '$.clock2.hour') AS hour2,
    json_extract(input, '$.clock2.minute') AS minute2
  FROM clock
), totals AS (
  SELECT
    id,
    property,
    CASE property
      WHEN 'create' THEN hour * 60 + minute
      WHEN 'add' THEN hour * 60 + minute + value
      WHEN 'subtract' THEN hour * 60 + minute - value
    END AS total_minutes,
    ((hour1 * 60 + minute1) % 1440 + 1440) % 1440 AS time1,
    ((hour2 * 60 + minute2) % 1440 + 1440) % 1440 AS time2
  FROM parsed
)
UPDATE clock
SET result = CASE totals.property
  WHEN 'create' THEN printf(
    '%02d:%02d',
    (((totals.total_minutes % 1440 + 1440) % 1440) / 60),
    ((totals.total_minutes % 1440 + 1440) % 1440) % 60
  )
  WHEN 'add' THEN printf(
    '%02d:%02d',
    (((totals.total_minutes % 1440 + 1440) % 1440) / 60),
    ((totals.total_minutes % 1440 + 1440) % 1440) % 60
  )
  WHEN 'subtract' THEN printf(
    '%02d:%02d',
    (((totals.total_minutes % 1440 + 1440) % 1440) / 60),
    ((totals.total_minutes % 1440 + 1440) % 1440) % 60
  )
  WHEN 'equal' THEN CASE WHEN totals.time1 = totals.time2 THEN '1' ELSE '0' END
END
FROM totals
WHERE clock.rowid = totals.id;
