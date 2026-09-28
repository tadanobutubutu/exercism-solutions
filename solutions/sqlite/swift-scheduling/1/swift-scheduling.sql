-- Schema:
-- CREATE TABLE "swift-scheduling" (
--     meeting_start    TEXT NOT NULL, -- datetime YYYY-MM-DDTHH:mm:ss
--     date_description TEXT NOT NULL,
--     result           TEXT           -- datetime YYYY-MM-DDTHH:mm:ss
-- );
--
-- Task: update swift-scheduling table and set the result based on the meeting_start and description.
WITH inputs AS (
  SELECT
    rowid AS id,
    meeting_start,
    date_description,
    CAST(strftime('%Y', meeting_start) AS INTEGER) AS start_year,
    CAST(strftime('%m', meeting_start) AS INTEGER) AS start_month,
    CAST(strftime('%w', meeting_start) AS INTEGER) AS start_weekday,
    CASE
      WHEN substr(date_description, 1, 1) = 'Q'
        THEN CAST(substr(date_description, 2) AS INTEGER)
      ELSE CAST(substr(date_description, 1, length(date_description) - 1) AS INTEGER)
    END AS target_number
  FROM "swift-scheduling"
), targets AS (
  SELECT
    *,
    CASE
      WHEN substr(date_description, -1) = 'M' THEN target_number
      WHEN substr(date_description, 1, 1) = 'Q' THEN target_number * 3
    END AS target_month,
    CASE
      WHEN substr(date_description, -1) = 'M'
        THEN start_year + CASE WHEN start_month >= target_number THEN 1 ELSE 0 END
      WHEN substr(date_description, 1, 1) = 'Q'
        THEN start_year + CASE WHEN (start_month - 1) / 3 + 1 > target_number THEN 1 ELSE 0 END
    END AS target_year
  FROM inputs
), month_dates AS (
  SELECT
    id,
    date(printf('%04d-%02d-01', target_year, target_month)) AS first_day,
    date(printf('%04d-%02d-01', target_year, target_month), '+1 month', '-1 day') AS last_day
  FROM targets
), computed AS (
  SELECT
    targets.id,
    CASE
      WHEN date_description = 'NOW'
        THEN strftime('%Y-%m-%dT%H:%M:%S', meeting_start, '+2 hours')
      WHEN date_description = 'ASAP' AND time(meeting_start) < '13:00:00'
        THEN substr(meeting_start, 1, 10) || 'T17:00:00'
      WHEN date_description = 'ASAP'
        THEN strftime('%Y-%m-%d', meeting_start, '+1 day') || 'T13:00:00'
      WHEN date_description = 'EOW' AND start_weekday BETWEEN 1 AND 3
        THEN date(meeting_start, printf('+%d days', 5 - start_weekday)) || 'T17:00:00'
      WHEN date_description = 'EOW'
        THEN date(meeting_start, printf('+%d days', 7 - start_weekday)) || 'T20:00:00'
      WHEN substr(date_description, -1) = 'M'
        THEN date(
          month_dates.first_day,
          printf('+%d days', CASE CAST(strftime('%w', month_dates.first_day) AS INTEGER)
            WHEN 6 THEN 2 WHEN 0 THEN 1 ELSE 0 END)
        ) || 'T08:00:00'
      WHEN substr(date_description, 1, 1) = 'Q'
        THEN date(
          month_dates.last_day,
          printf('-%d days', CASE CAST(strftime('%w', month_dates.last_day) AS INTEGER)
            WHEN 6 THEN 1 WHEN 0 THEN 2 ELSE 0 END)
        ) || 'T08:00:00'
    END AS result
  FROM targets
  JOIN month_dates ON month_dates.id = targets.id
)
UPDATE "swift-scheduling"
SET result = (SELECT result FROM computed WHERE computed.id = "swift-scheduling".rowid);
