WITH RECURSIVE
source AS (
  SELECT rowid AS id, phrase FROM "pig-latin"
),
words(id, word_no, word, rest) AS (
  SELECT id,
         1,
         substr(trim(phrase) || ' ', 1, instr(trim(phrase) || ' ', ' ') - 1),
         substr(trim(phrase) || ' ', instr(trim(phrase) || ' ', ' ') + 1)
    FROM source
   WHERE trim(phrase) <> ''
  UNION ALL
  SELECT id,
         word_no + 1,
         substr(rest, 1, instr(rest, ' ') - 1),
         substr(rest, instr(rest, ' ') + 1)
    FROM words
   WHERE rest <> ''
),
positions(id, word_no, word, position) AS (
  SELECT id, word_no, word, 1 FROM words WHERE word <> ''
  UNION ALL
  SELECT id, word_no, word, position + 1
    FROM positions
   WHERE position < length(word)
),
candidates(id, word_no, cut_at) AS (
  SELECT id, word_no, 0
    FROM words
   WHERE lower(substr(word, 1, 1)) IN ('a', 'e', 'i', 'o', 'u')
      OR lower(substr(word, 1, 2)) IN ('xr', 'yt')
  UNION ALL
  SELECT id, word_no, position + 1
    FROM positions
   WHERE lower(substr(word, position, 2)) = 'qu'
  UNION ALL
  SELECT id, word_no, position - 1
    FROM positions
   WHERE position > 1
     AND lower(substr(word, position, 1)) = 'y'
  UNION ALL
  SELECT id, word_no, position - 1
    FROM positions
   WHERE lower(substr(word, position, 1)) IN ('a', 'e', 'i', 'o', 'u')
     AND NOT (lower(substr(word, position, 1)) = 'u'
              AND lower(substr(word, position - 1, 1)) = 'q')
),
cutoffs AS (
  SELECT w.id, w.word_no, w.word,
         COALESCE(MIN(c.cut_at), length(w.word)) AS cut_at
    FROM words AS w
    LEFT JOIN candidates AS c ON c.id = w.id AND c.word_no = w.word_no
   WHERE w.word <> ''
   GROUP BY w.id, w.word_no, w.word
),
translated AS (
  SELECT id, word_no,
         substr(word, cut_at + 1) || substr(word, 1, cut_at) || 'ay' AS word
    FROM cutoffs
),
answers AS (
  SELECT s.id,
         COALESCE((SELECT group_concat(word, ' ')
                     FROM (SELECT word FROM translated AS t
                            WHERE t.id = s.id
                            ORDER BY word_no)), '') AS result
    FROM source AS s
)
UPDATE "pig-latin"
   SET result = answers.result
  FROM answers
 WHERE "pig-latin".rowid = answers.id;
