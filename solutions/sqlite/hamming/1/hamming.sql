WITH RECURSIVE
walk(id, strand1, strand2, position, difference) AS (
  SELECT rowid, strand1, strand2, 1, 0
    FROM hamming
  UNION ALL
  SELECT id, strand1, strand2, position + 1,
         difference + (substr(strand1, position, 1) <> substr(strand2, position, 1))
    FROM walk
   WHERE length(strand1) = length(strand2)
     AND position <= length(strand1)
),
final AS (
  SELECT id, difference
    FROM walk
   WHERE position > length(strand1)
     AND length(strand1) = length(strand2)
)
UPDATE hamming
   SET result = (SELECT difference FROM final WHERE final.id = hamming.rowid),
       error = CASE WHEN length(strand1) <> length(strand2)
                    THEN 'strands must be of equal length'
                    ELSE NULL END;
