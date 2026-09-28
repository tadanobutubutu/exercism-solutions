WITH RECURSIVE
walk(id, input, position, stack, valid) AS (
  SELECT rowid, input, 1, '', 1 FROM "matching-brackets"
  UNION ALL
  SELECT id,
         input,
         position + 1,
         CASE
           WHEN valid = 0 THEN stack
           WHEN substr(input, position, 1) IN ('(', '[', '{')
             THEN stack || substr(input, position, 1)
           WHEN substr(input, position, 1) = ')' AND substr(stack, -1, 1) = '(' THEN substr(stack, 1, length(stack) - 1)
           WHEN substr(input, position, 1) = ']' AND substr(stack, -1, 1) = '[' THEN substr(stack, 1, length(stack) - 1)
           WHEN substr(input, position, 1) = '}' AND substr(stack, -1, 1) = '{' THEN substr(stack, 1, length(stack) - 1)
           ELSE stack
         END,
         CASE
           WHEN valid = 0 THEN 0
           WHEN substr(input, position, 1) = ')' AND substr(stack, -1, 1) <> '(' THEN 0
           WHEN substr(input, position, 1) = ']' AND substr(stack, -1, 1) <> '[' THEN 0
           WHEN substr(input, position, 1) = '}' AND substr(stack, -1, 1) <> '{' THEN 0
           ELSE 1
         END
    FROM walk
   WHERE position <= length(input)
),
final AS (
  SELECT id, valid AND stack = '' AS result
    FROM walk
   WHERE position > length(input)
)
UPDATE "matching-brackets"
   SET result = final.result
  FROM final
 WHERE "matching-brackets".rowid = final.id;
