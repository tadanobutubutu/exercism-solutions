-- Schema:
-- CREATE TABLE house (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update house table and set the result based on the start_verse and end_verse.
WITH RECURSIVE phrases(verse, object, action) AS (
  VALUES
    (1, 'the house', ''),
    (2, 'the malt', 'that lay in'),
    (3, 'the rat', 'that ate'),
    (4, 'the cat', 'that killed'),
    (5, 'the dog', 'that worried'),
    (6, 'the cow with the crumpled horn', 'that tossed'),
    (7, 'the maiden all forlorn', 'that milked'),
    (8, 'the man all tattered and torn', 'that kissed'),
    (9, 'the priest all shaven and shorn', 'that married'),
    (10, 'the rooster that crowed in the morn', 'that woke'),
    (11, 'the farmer sowing his corn', 'that kept'),
    (12, 'the horse and the hound and the horn', 'that belonged to')
), verse_build(start_verse, current_verse, text) AS (
  SELECT verse, verse, 'This is ' || object
  FROM phrases
  UNION ALL
  SELECT verse_build.start_verse,
         verse_build.current_verse - 1,
         verse_build.text || ' ' || current.action || ' ' || previous.object
  FROM verse_build
  JOIN phrases AS current ON current.verse = verse_build.current_verse
  JOIN phrases AS previous ON previous.verse = verse_build.current_verse - 1
  WHERE verse_build.current_verse > 1
), complete_verses AS (
  SELECT start_verse, text || ' that Jack built.' AS text
  FROM verse_build
  WHERE current_verse = 1
)
UPDATE house
SET result = (
  SELECT group_concat(text, char(10))
  FROM (
    SELECT text
    FROM complete_verses
    WHERE start_verse BETWEEN house.start_verse AND house.end_verse
    ORDER BY start_verse
  )
);
