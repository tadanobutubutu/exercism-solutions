WITH RECURSIVE
walk(id, word, position, total) AS (
  SELECT rowid, upper(word), 1, 0 FROM "scrabble-score"
  UNION ALL
  SELECT id,
         word,
         position + 1,
         total + CASE
           WHEN substr(word, position, 1) IN ('A','E','I','O','U','L','N','R','S','T') THEN 1
           WHEN substr(word, position, 1) IN ('D','G') THEN 2
           WHEN substr(word, position, 1) IN ('B','C','M','P') THEN 3
           WHEN substr(word, position, 1) IN ('F','H','V','W','Y') THEN 4
           WHEN substr(word, position, 1) = 'K' THEN 5
           WHEN substr(word, position, 1) IN ('J','X') THEN 8
           WHEN substr(word, position, 1) IN ('Q','Z') THEN 10
           ELSE 0
         END
    FROM walk
   WHERE position <= length(word)
),
final AS (
  SELECT id, total FROM walk WHERE position > length(word)
)
UPDATE "scrabble-score"
   SET result = final.total
  FROM final
 WHERE "scrabble-score".rowid = final.id;
