WITH RECURSIVE
numbers(id, bound, value) AS (
  SELECT rowid, "limit", 2 FROM sieve WHERE "limit" >= 2
  UNION ALL
  SELECT id, bound, value + 1
    FROM numbers
   WHERE value < bound
),
primes AS (
  SELECT n.id, n.value
    FROM numbers AS n
   WHERE NOT EXISTS (
     SELECT 1
       FROM numbers AS d
      WHERE d.id = n.id
        AND d.value * d.value <= n.value
        AND n.value % d.value = 0
   )
),
answers AS (
  SELECT s.rowid AS id,
         COALESCE((SELECT group_concat(value, ', ')
                     FROM (SELECT value FROM primes AS p
                            WHERE p.id = s.rowid
                            ORDER BY value)), '') AS result
    FROM sieve AS s
)
UPDATE sieve
   SET result = answers.result
  FROM answers
 WHERE sieve.rowid = answers.id;
