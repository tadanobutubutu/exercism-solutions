WITH
lines AS (
  SELECT p.rowid AS id,
         CAST(a.key AS INTEGER) AS position,
         a.value AS item,
         LEAD(a.value) OVER (PARTITION BY p.rowid ORDER BY CAST(a.key AS INTEGER)) AS next_item
    FROM proverb AS p,
         json_each(p.strings) AS a
),
proverbs AS (
  SELECT id, position,
         'For want of a ' || item || ' the ' || next_item || ' was lost.' AS line
    FROM lines
   WHERE next_item IS NOT NULL
),
answers AS (
  SELECT p.rowid AS id,
         COALESCE((SELECT group_concat(line, char(10))
                     FROM (SELECT line FROM proverbs AS v
                            WHERE v.id = p.rowid
                            ORDER BY position)), '') ||
         CASE WHEN json_array_length(p.strings) > 0
              THEN CASE WHEN json_array_length(p.strings) > 1 THEN char(10) ELSE '' END ||
                   'And all for the want of a ' || json_extract(p.strings, '$[0]') || '.'
              ELSE '' END AS result
    FROM proverb AS p
)
UPDATE proverb
   SET result = answers.result
  FROM answers
 WHERE proverb.rowid = answers.id;
