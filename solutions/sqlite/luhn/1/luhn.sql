WITH RECURSIVE
cleaned(id, value, digits) AS (
  SELECT rowid, value, replace(value, ' ', '') FROM luhn
),
walk(id, digits, position, total) AS (
  SELECT id, digits, 1, 0 FROM cleaned
  UNION ALL
  SELECT id,
         digits,
         position + 1,
         total + CASE
           WHEN (length(digits) - position) % 2 = 1 THEN
             CASE WHEN CAST(substr(digits, position, 1) AS INTEGER) * 2 > 9
                  THEN CAST(substr(digits, position, 1) AS INTEGER) * 2 - 9
                  ELSE CAST(substr(digits, position, 1) AS INTEGER) * 2 END
           ELSE CAST(substr(digits, position, 1) AS INTEGER)
         END
    FROM walk
   WHERE position <= length(digits)
),
sums AS (
  SELECT id, digits, total
    FROM walk
   WHERE position > length(digits)
)
UPDATE luhn
   SET result = CASE
         WHEN length(sums.digits) > 1
          AND sums.digits NOT GLOB '*[^0-9]*'
          AND sums.total % 10 = 0 THEN 1
         ELSE 0
       END
  FROM sums
 WHERE luhn.rowid = sums.id;
