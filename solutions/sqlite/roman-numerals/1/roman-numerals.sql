WITH RECURSIVE
denominations(position, value, symbol) AS (
  VALUES
    (1, 1000, 'M'),
    (2, 900, 'CM'),
    (3, 500, 'D'),
    (4, 400, 'CD'),
    (5, 100, 'C'),
    (6, 90, 'XC'),
    (7, 50, 'L'),
    (8, 40, 'XL'),
    (9, 10, 'X'),
    (10, 9, 'IX'),
    (11, 5, 'V'),
    (12, 4, 'IV'),
    (13, 1, 'I')
),
walk(id, remainder, position, result) AS (
  SELECT rowid, number, 1, '' FROM "roman-numerals"
  UNION ALL
  SELECT w.id,
         CASE WHEN w.remainder >= d.value THEN w.remainder - d.value ELSE w.remainder END,
         CASE WHEN w.remainder >= d.value THEN w.position ELSE w.position + 1 END,
         CASE WHEN w.remainder >= d.value THEN w.result || d.symbol ELSE w.result END
    FROM walk AS w
    JOIN denominations AS d ON d.position = w.position
   WHERE w.remainder > 0
),
final AS (
  SELECT id, result FROM walk WHERE remainder = 0
)
UPDATE "roman-numerals"
   SET result = final.result
  FROM final
 WHERE "roman-numerals".rowid = final.id;
