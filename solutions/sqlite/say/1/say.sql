WITH
  words(value, word) AS (
    VALUES
      (0, 'zero'), (1, 'one'), (2, 'two'), (3, 'three'), (4, 'four'),
      (5, 'five'), (6, 'six'), (7, 'seven'), (8, 'eight'), (9, 'nine'),
      (10, 'ten'), (11, 'eleven'), (12, 'twelve'), (13, 'thirteen'),
      (14, 'fourteen'), (15, 'fifteen'), (16, 'sixteen'), (17, 'seventeen'),
      (18, 'eighteen'), (19, 'nineteen'), (20, 'twenty'), (30, 'thirty'),
      (40, 'forty'), (50, 'fifty'), (60, 'sixty'), (70, 'seventy'),
      (80, 'eighty'), (90, 'ninety')
  ),
  scales(scale, magnitude, position) AS (
    VALUES
      (1000000000, 'billion', 3),
      (1000000, 'million', 2),
      (1000, 'thousand', 1),
      (1, '', 0)
  ),
  groups AS (
    SELECT
      say.number,
      scales.position,
      scales.magnitude,
      say.number / scales.scale % 1000 AS value
    FROM say
    CROSS JOIN scales
    WHERE say.number BETWEEN 0 AND 999999999999
      AND say.number / scales.scale % 1000 > 0
  ),
  group_words AS (
    SELECT
      groups.number,
      groups.position,
      TRIM(
        CASE
          WHEN groups.value / 100 > 0 THEN
            (SELECT word FROM words WHERE value = groups.value / 100) || ' hundred'
          ELSE ''
        END
        || CASE
          WHEN groups.value % 100 BETWEEN 1 AND 19 THEN
            CASE WHEN groups.value / 100 > 0 THEN ' ' ELSE '' END
            || (SELECT word FROM words WHERE value = groups.value % 100)
          WHEN groups.value % 100 >= 20 THEN
            CASE WHEN groups.value / 100 > 0 THEN ' ' ELSE '' END
            || (SELECT word FROM words WHERE value = groups.value % 100 / 10 * 10)
            || CASE
              WHEN groups.value % 10 > 0 THEN
                '-' || (SELECT word FROM words WHERE value = groups.value % 10)
              ELSE ''
            END
          ELSE ''
        END
        || CASE
          WHEN groups.magnitude <> '' THEN ' ' || groups.magnitude
          ELSE ''
        END
      ) AS word
    FROM groups
  ),
  spoken AS (
    SELECT
      say.number,
      CASE
        WHEN say.number = 0 THEN 'zero'
        ELSE (
          SELECT group_concat(word, ' ')
          FROM (
            SELECT word
            FROM group_words
            WHERE group_words.number = say.number
            ORDER BY position DESC
          )
        )
      END AS result,
      CASE
        WHEN say.number < 0 OR say.number > 999999999999 THEN 'input out of range'
        ELSE NULL
      END AS error
    FROM say
  )
UPDATE say
SET
  result = (SELECT result FROM spoken WHERE spoken.number = say.number),
  error = (SELECT error FROM spoken WHERE spoken.number = say.number);
