WITH RECURSIVE
scan(id, sentence, position, word, tokens) AS (
  SELECT rowid, lower(sentence), 1, '', '' FROM "word-count"
  UNION ALL
  SELECT id,
         sentence,
         position + 1,
         CASE
           WHEN substr(sentence, position, 1) GLOB '[a-z0-9]'
             THEN word || substr(sentence, position, 1)
           WHEN substr(sentence, position, 1) = char(39)
            AND word <> ''
            AND substr(sentence, position + 1, 1) GLOB '[a-z0-9]'
             THEN word || char(39)
           ELSE ''
         END,
         CASE
           WHEN substr(sentence, position, 1) GLOB '[a-z0-9]' THEN tokens
           WHEN substr(sentence, position, 1) = char(39)
            AND word <> ''
            AND substr(sentence, position + 1, 1) GLOB '[a-z0-9]' THEN tokens
           WHEN word <> '' THEN tokens || word || char(31)
           ELSE tokens
         END
    FROM scan
   WHERE position <= length(sentence)
),
streams AS (
  SELECT id,
         tokens || CASE WHEN word <> '' THEN word || char(31) ELSE '' END AS stream
    FROM scan
   WHERE position > length(sentence)
),
tokens(id, rest, token) AS (
  SELECT id,
         stream,
         substr(stream, 1, instr(stream, char(31)) - 1)
    FROM streams
   WHERE stream <> ''
  UNION ALL
  SELECT id,
         substr(rest, instr(rest, char(31)) + 1),
         substr(substr(rest, instr(rest, char(31)) + 1), 1,
                instr(substr(rest, instr(rest, char(31)) + 1), char(31)) - 1)
    FROM tokens
   WHERE instr(rest, char(31)) < length(rest)
),
counts AS (
  SELECT id, token, COUNT(*) AS n
    FROM tokens
   WHERE token <> ''
   GROUP BY id, token
),
objects AS (
  SELECT id, json_group_object(token, n) AS result
    FROM counts
   GROUP BY id
)
UPDATE "word-count"
   SET result = COALESCE(objects.result, '{}')
  FROM objects
 WHERE "word-count".rowid = objects.id;

UPDATE "word-count"
   SET result = '{}'
 WHERE result IS NULL;
