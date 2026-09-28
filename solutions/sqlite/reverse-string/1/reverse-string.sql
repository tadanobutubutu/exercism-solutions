WITH RECURSIVE
walk(id, input, position, reversed) AS (
  SELECT rowid, input, length(input), '' FROM "reverse-string"
  UNION ALL
  SELECT id,
         input,
         position - 1,
         reversed || substr(input, position, 1)
    FROM walk
   WHERE position > 0
),
final AS (
  SELECT id, reversed FROM walk WHERE position = 0
)
UPDATE "reverse-string"
   SET result = final.reversed
  FROM final
 WHERE "reverse-string".rowid = final.id;
