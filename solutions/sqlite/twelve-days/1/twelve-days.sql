-- Schema:
-- CREATE TABLE "twelve-days" (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update the twelve-days table and set result bases on the start_verse and end_verse.
WITH RECURSIVE verses(day, ordinal) AS (
  VALUES
    (1, 'first'), (2, 'second'), (3, 'third'), (4, 'fourth'),
    (5, 'fifth'), (6, 'sixth'), (7, 'seventh'), (8, 'eighth'),
    (9, 'ninth'), (10, 'tenth'), (11, 'eleventh'), (12, 'twelfth')
), gifts(day, text) AS (
  VALUES
    (1, 'a Partridge in a Pear Tree'),
    (2, 'two Turtle Doves'),
    (3, 'three French Hens'),
    (4, 'four Calling Birds'),
    (5, 'five Gold Rings'),
    (6, 'six Geese-a-Laying'),
    (7, 'seven Swans-a-Swimming'),
    (8, 'eight Maids-a-Milking'),
    (9, 'nine Ladies Dancing'),
    (10, 'ten Lords-a-Leaping'),
    (11, 'eleven Pipers Piping'),
    (12, 'twelve Drummers Drumming')
), lines AS (
  SELECT
    verses.day,
    'On the ' || verses.ordinal || ' day of Christmas my true love gave to me: ' ||
      (SELECT group_concat(
        CASE WHEN gifts.day = 1 AND verses.day > 1
          THEN 'and ' || gifts.text
          ELSE gifts.text
        END,
        ', '
      )
      FROM (
        SELECT day, text
        FROM gifts
        WHERE day <= verses.day
        ORDER BY day DESC
      ) AS gifts) || '.' AS text
  FROM verses
)
UPDATE "twelve-days"
SET result = (
  SELECT group_concat(text, char(10))
  FROM (
    SELECT text
    FROM lines
    WHERE day BETWEEN "twelve-days".start_verse AND "twelve-days".end_verse
    ORDER BY day
  )
);
