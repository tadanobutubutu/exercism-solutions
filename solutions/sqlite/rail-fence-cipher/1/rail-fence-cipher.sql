WITH RECURSIVE
source AS (
  SELECT rowid AS id, property, msg, rails FROM "rail-fence-cipher"
),
positions(id, property, msg, rails, position) AS (
  SELECT id, property, msg, rails, 1 FROM source WHERE length(msg) > 0
  UNION ALL
  SELECT id, property, msg, rails, position + 1
    FROM positions
   WHERE position < length(msg)
),
rail_assignments AS (
  SELECT id, property, msg, rails, position,
         CASE WHEN rails <= 1 THEN 0
              WHEN ((position - 1) % (2 * (rails - 1))) < rails
                THEN (position - 1) % (2 * (rails - 1))
              ELSE 2 * (rails - 1) - ((position - 1) % (2 * (rails - 1)))
          END AS rail,
         substr(msg, position, 1) AS character
    FROM positions
),
ranked AS (
  SELECT id, property, msg, rails, position, rail, character,
         ROW_NUMBER() OVER (PARTITION BY id, rail ORDER BY position) AS rank_in_rail
    FROM rail_assignments
),
rail_counts AS (
  SELECT id, rail, COUNT(*) AS count FROM ranked GROUP BY id, rail
),
answers AS (
  SELECT s.id,
         CASE WHEN s.property = 'encode'
              THEN COALESCE((SELECT group_concat(character, '')
                               FROM (SELECT character FROM ranked AS r
                                      WHERE r.id = s.id
                                      ORDER BY rail, position)), '')
              ELSE COALESCE((SELECT group_concat(substr(msg,
                                       (SELECT COALESCE(SUM(count), 0)
                                          FROM rail_counts AS c
                                         WHERE c.id = r.id AND c.rail < r.rail)
                                       + rank_in_rail, 1), '')
                               FROM (SELECT * FROM ranked AS r0 WHERE r0.id = s.id ORDER BY position) AS r), '')
          END AS result
    FROM source AS s
)
UPDATE "rail-fence-cipher"
   SET result = answers.result
  FROM answers
 WHERE "rail-fence-cipher".rowid = answers.id;
