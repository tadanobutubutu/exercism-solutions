-- Schema: CREATE TABLE acronym ( phrase TEXT PRIMARY KEY, result TEXT );
-- Task: update the acronym table and set the result based on the phrase.
WITH RECURSIVE characters(id, phrase, position, in_word, initials) AS (
  SELECT rowid, phrase, 1, 0, ''
  FROM acronym
  UNION ALL
  SELECT
    id,
    phrase,
    position + 1,
    CASE
      WHEN substr(phrase, position, 1) IN (' ', '-') THEN 0
      WHEN upper(substr(phrase, position, 1)) BETWEEN 'A' AND 'Z' THEN 1
      ELSE in_word
    END,
    initials || CASE
      WHEN upper(substr(phrase, position, 1)) BETWEEN 'A' AND 'Z' AND in_word = 0
        THEN upper(substr(phrase, position, 1))
      ELSE ''
    END
  FROM characters
  WHERE position <= length(phrase)
)
UPDATE acronym
SET result = (
  SELECT initials
  FROM characters
  WHERE characters.id = acronym.rowid
    AND characters.position > length(acronym.phrase)
);
