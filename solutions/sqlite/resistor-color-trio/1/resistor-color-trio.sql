-- Schema: CREATE TABLE IF NOT EXISTS color_code ( color1 TEXT, color2 TEXT, color3 TEXT, result TEXT );
-- Task: update the color_code table and set the result based on the colors.
WITH colors(color, digit) AS (
  VALUES
    ('black', 0), ('brown', 1), ('red', 2), ('orange', 3),
    ('yellow', 4), ('green', 5), ('blue', 6), ('violet', 7),
    ('grey', 8), ('white', 9)
), decoded AS (
  SELECT
    color_code.rowid AS id,
    (first.digit * 10 + second.digit) *
      CASE third.digit
        WHEN 0 THEN 1 WHEN 1 THEN 10 WHEN 2 THEN 100
        WHEN 3 THEN 1000 WHEN 4 THEN 10000 WHEN 5 THEN 100000
        WHEN 6 THEN 1000000 WHEN 7 THEN 10000000
        WHEN 8 THEN 100000000 WHEN 9 THEN 1000000000
      END AS ohms
  FROM color_code
  JOIN colors AS first ON first.color = color_code.color1
  JOIN colors AS second ON second.color = color_code.color2
  JOIN colors AS third ON third.color = color_code.color3
)
UPDATE color_code
SET result = CASE
  WHEN decoded.ohms < 1000 THEN printf('%d ohms', decoded.ohms)
  WHEN decoded.ohms < 1000000 THEN printf('%d kiloohms', decoded.ohms / 1000)
  WHEN decoded.ohms < 1000000000 THEN printf('%d megaohms', decoded.ohms / 1000000)
  ELSE printf('%d gigaohms', decoded.ohms / 1000000000)
END
FROM decoded
WHERE color_code.rowid = decoded.id;
