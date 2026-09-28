-- Schema:
-- CREATE TABLE "bottle-song" (
--         start_bottles INTEGER NOT NULL,
--         take_down     INTEGER NOT NULL,
--         result        TEXT
-- );
-- Task: update bottle-song table and set the result based on the
-- start_bottles and take_down.
WITH RECURSIVE
number_words(n, title_word, lower_word) AS (
  VALUES
    (0, 'No', 'no'),
    (1, 'One', 'one'),
    (2, 'Two', 'two'),
    (3, 'Three', 'three'),
    (4, 'Four', 'four'),
    (5, 'Five', 'five'),
    (6, 'Six', 'six'),
    (7, 'Seven', 'seven'),
    (8, 'Eight', 'eight'),
    (9, 'Nine', 'nine'),
    (10, 'Ten', 'ten')
),
verses(start_bottles, take_down, step, number) AS (
  SELECT start_bottles, take_down, 1, start_bottles
  FROM "bottle-song"
  UNION ALL
  SELECT start_bottles, take_down, step + 1, number - 1
  FROM verses
  WHERE step < take_down
),
formatted AS (
  SELECT
    verses.start_bottles,
    verses.take_down,
    verses.step,
    current.title_word || ' green bottle' || CASE WHEN verses.number = 1 THEN '' ELSE 's' END || ' hanging on the wall,' || char(10) ||
    current.title_word || ' green bottle' || CASE WHEN verses.number = 1 THEN '' ELSE 's' END || ' hanging on the wall,' || char(10) ||
    'And if one green bottle should accidentally fall,' || char(10) ||
    'There''ll be ' || following.lower_word || ' green bottle' || CASE WHEN verses.number - 1 = 1 THEN '' ELSE 's' END || ' hanging on the wall.' AS verse
  FROM verses
  JOIN number_words AS current ON current.n = verses.number
  JOIN number_words AS following ON following.n = verses.number - 1
),
ordered_verses AS (
  SELECT start_bottles, take_down, step, verse
  FROM formatted
  ORDER BY start_bottles, take_down, step
),
results AS (
  SELECT start_bottles, take_down, group_concat(verse, char(10) || char(10)) AS result
  FROM ordered_verses
  GROUP BY start_bottles, take_down
)
UPDATE "bottle-song"
SET result = COALESCE((
  SELECT results.result
  FROM results
  WHERE results.start_bottles = "bottle-song".start_bottles
    AND results.take_down = "bottle-song".take_down
), '');
