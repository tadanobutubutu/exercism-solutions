WITH RECURSIVE
animals(verse, animal, intro) AS (
  VALUES
    (1, 'fly', NULL),
    (2, 'spider', 'It wriggled and jiggled and tickled inside her.'),
    (3, 'bird', 'How absurd to swallow a bird!'),
    (4, 'cat', 'Imagine that, to swallow a cat!'),
    (5, 'dog', 'What a hog, to swallow a dog!'),
    (6, 'goat', 'Just opened her throat and swallowed a goat!'),
    (7, 'cow', 'I don''t know how she swallowed a cow!'),
    (8, 'horse', 'She''s dead, of course!')
),
chain(verse, current) AS (
  SELECT verse, verse FROM animals WHERE verse BETWEEN 2 AND 7
  UNION ALL
  SELECT verse, current - 1 FROM chain WHERE current > 2
),
lines(verse, sequence, line) AS (
  SELECT verse, 1, 'I know an old lady who swallowed a ' || animal || '.'
    FROM animals
  UNION ALL
  SELECT verse, 2, intro FROM animals WHERE intro IS NOT NULL AND verse < 8
  UNION ALL
  SELECT c.verse,
         3 + c.verse - c.current,
         'She swallowed the ' || a.animal || ' to catch the ' || p.animal ||
           CASE WHEN p.animal = 'spider'
                THEN ' that wriggled and jiggled and tickled inside her.'
                ELSE '.' END
    FROM chain AS c
    JOIN animals AS a ON a.verse = c.current
    JOIN animals AS p ON p.verse = c.current - 1
  UNION ALL
  SELECT verse,
         CASE WHEN verse = 8 THEN 2 ELSE 100 END,
         CASE WHEN verse = 8
              THEN intro
              ELSE 'I don''t know why she swallowed the fly. Perhaps she''ll die.'
          END
    FROM animals
   WHERE verse = 8 OR verse < 8
),
verse_text AS (
  SELECT a.verse,
         (SELECT group_concat(line, char(10))
            FROM (SELECT line FROM lines AS l
                   WHERE l.verse = a.verse
                   ORDER BY sequence)
         ) AS text
    FROM animals AS a
)
UPDATE "food-chain"
   SET result = (
     SELECT group_concat(text, char(10) || char(10))
       FROM (SELECT text FROM verse_text
              WHERE verse BETWEEN "food-chain".start_verse AND "food-chain".end_verse
              ORDER BY verse)
   );
