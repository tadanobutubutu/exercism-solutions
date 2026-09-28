-- Schema: CREATE TABLE "atbash-cipher" (
--           property TEXT NOT NULL,
--           phrase   TEXT NOT NULL,
--           result   TEXT
--         );
-- Task: update the atbash-cipher table and set the result based on
--       property and phrase
WITH RECURSIVE transformed(id, property, phrase, position, text, count) AS (
  SELECT rowid, property, phrase, 1, '', 0
  FROM "atbash-cipher"
  UNION ALL
  SELECT
    id,
    property,
    phrase,
    position + 1,
    text ||
      CASE
        WHEN property = 'encode' AND count > 0 AND count % 5 = 0
          AND (
            unicode(lower(substr(phrase, position, 1))) BETWEEN 97 AND 122
            OR substr(phrase, position, 1) GLOB '[0-9]'
          ) THEN ' '
        ELSE ''
      END ||
      CASE
        WHEN unicode(lower(substr(phrase, position, 1))) BETWEEN 97 AND 122
          THEN char(219 - unicode(lower(substr(phrase, position, 1))))
        WHEN substr(phrase, position, 1) GLOB '[0-9]'
          THEN substr(phrase, position, 1)
        ELSE ''
      END,
    count + CASE
      WHEN unicode(lower(substr(phrase, position, 1))) BETWEEN 97 AND 122
        OR substr(phrase, position, 1) GLOB '[0-9]'
      THEN 1 ELSE 0
    END
  FROM transformed
  WHERE position <= length(phrase)
)
UPDATE "atbash-cipher"
SET result = (
  SELECT text
  FROM transformed
  WHERE transformed.id = "atbash-cipher".rowid
    AND transformed.position > length("atbash-cipher".phrase)
);
