-- Schema: CREATE TABLE "meetup" ( "year" INTEGER, "month" INTEGER, "week" TEXT, "dayofweek" TEXT, "result" TEXT);
-- Task: update the meetup table and set the result based on the other fields.
WITH RECURSIVE days(day) AS (
  VALUES (1)
  UNION ALL
  SELECT day + 1 FROM days WHERE day < 31
), requests AS (
  SELECT rowid AS id, "year", month, week, dayofweek
  FROM meetup
), candidates AS (
  SELECT
    requests.id,
    requests.week,
    days.day,
    date(printf('%04d-%02d-%02d', requests."year", requests.month, days.day)) AS meetup_date
  FROM requests
  CROSS JOIN days
  WHERE days.day <= CAST(
    strftime(
      '%d',
      date(printf('%04d-%02d-01', requests."year", requests.month), '+1 month', '-1 day')
    ) AS INTEGER
  )
    AND CAST(strftime('%w', date(printf('%04d-%02d-%02d', requests."year", requests.month, days.day))) AS INTEGER)
      = CASE requests.dayofweek
        WHEN 'Sunday' THEN 0 WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3 WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
      END
    AND CASE requests.week
      WHEN 'teenth' THEN days.day BETWEEN 13 AND 19
      WHEN 'first' THEN days.day BETWEEN 1 AND 7
      WHEN 'second' THEN days.day BETWEEN 8 AND 14
      WHEN 'third' THEN days.day BETWEEN 15 AND 21
      WHEN 'fourth' THEN days.day BETWEEN 22 AND 28
      WHEN 'last' THEN 1
    END
)
UPDATE meetup
SET result = (
  SELECT meetup_date
  FROM candidates
  WHERE candidates.id = meetup.rowid
  ORDER BY CASE WHEN candidates.week = 'last' THEN -candidates.day ELSE candidates.day END
  LIMIT 1
);
