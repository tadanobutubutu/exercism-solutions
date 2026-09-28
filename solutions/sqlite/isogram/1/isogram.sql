WITH RECURSIVE
walk(id, phrase, position, seen, unique_letters) AS (
  SELECT rowid, lower(phrase), 1, '', 1 FROM isogram
  UNION ALL
  SELECT id,
         phrase,
         position + 1,
         CASE
           WHEN substr(phrase, position, 1) IN (' ', '-') THEN seen
           WHEN instr(seen, substr(phrase, position, 1)) > 0 THEN seen
           ELSE seen || substr(phrase, position, 1)
         END,
         CASE
           WHEN substr(phrase, position, 1) IN (' ', '-') THEN unique_letters
           WHEN instr(seen, substr(phrase, position, 1)) > 0 THEN 0
           ELSE unique_letters
         END
    FROM walk
   WHERE position <= length(phrase)
),
final AS (
  SELECT id, unique_letters
    FROM walk
   WHERE position > length(phrase)
)
UPDATE isogram
   SET is_isogram = final.unique_letters
  FROM final
 WHERE isogram.rowid = final.id;
