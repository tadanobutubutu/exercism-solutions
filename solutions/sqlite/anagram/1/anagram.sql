-- Schema: CREATE TABLE anagram (
--           subject    TEXT NOT NULL,
--           candidates TEXT NOT NULL,     -- json array of strings
--           result     TEXT               -- json array of strings
--         );
-- Task: update the anagram table and set the result based on valid
--       candidates for the subject field
--       * the candidates column contains a JSON-encoded list of strings.
--       * the result column should contain JSON-encoded list of
--         strings as well.
WITH RECURSIVE letters(code) AS (
  VALUES (97)
  UNION ALL
  SELECT code + 1 FROM letters WHERE code < 122
), candidates AS (
  SELECT
    anagram.rowid AS id,
    anagram.subject,
    CAST(json_each.key AS INTEGER) AS position,
    json_each.value AS candidate
  FROM anagram, json_each(anagram.candidates)
), matches AS (
  SELECT candidates.*
  FROM candidates
  WHERE lower(candidate) <> lower(subject)
    AND length(candidate) = length(subject)
    AND NOT EXISTS (
      SELECT 1
      FROM letters
      WHERE length(lower(subject)) - length(replace(lower(subject), char(code), ''))
         <> length(lower(candidate)) - length(replace(lower(candidate), char(code), ''))
    )
)
UPDATE anagram
SET result = COALESCE(
  (
    SELECT json_group_array(candidate)
    FROM (
      SELECT candidate
      FROM matches
      WHERE matches.id = anagram.rowid
      ORDER BY position
    )
  ),
  '[]'
);
