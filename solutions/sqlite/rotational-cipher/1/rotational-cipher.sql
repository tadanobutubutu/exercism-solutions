WITH RECURSIVE
walk(id, text, shift_key, position, result) AS (
  SELECT rowid, text, shift_key, 1, '' FROM "rotational-cipher"
  UNION ALL
  SELECT id,
         text,
         shift_key,
         position + 1,
         result || CASE
           WHEN substr(text, position, 1) GLOB '[a-z]'
             THEN char((unicode(substr(text, position, 1)) - 97 + shift_key) % 26 + 97)
           WHEN substr(text, position, 1) GLOB '[A-Z]'
             THEN char((unicode(substr(text, position, 1)) - 65 + shift_key) % 26 + 65)
           ELSE substr(text, position, 1)
         END
    FROM walk
   WHERE position <= length(text)
),
final AS (
  SELECT id, result FROM walk WHERE position > length(text)
)
UPDATE "rotational-cipher"
   SET result = final.result
  FROM final
 WHERE "rotational-cipher".rowid = final.id;
