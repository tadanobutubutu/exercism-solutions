WITH
  dice AS (
    SELECT
      yacht.rowid AS round_id,
      CAST(die.value AS INTEGER) AS value
    FROM yacht
    CROSS JOIN json_each('[' || yacht.dice_results || ']') AS die
  ),
  face_counts AS (
    SELECT round_id, value, COUNT(*) AS quantity
    FROM dice
    GROUP BY round_id, value
  ),
  die_stats AS (
    SELECT
      dice.round_id,
      COUNT(*) AS dice_count,
      SUM(dice.value) AS total,
      MIN(dice.value) AS minimum,
      MAX(dice.value) AS maximum,
      COUNT(DISTINCT dice.value) AS distinct_faces
    FROM dice
    GROUP BY dice.round_id
  ),
  face_stats AS (
    SELECT
      face_counts.round_id,
      SUM(CASE WHEN face_counts.quantity = 2 THEN 1 ELSE 0 END) AS pairs,
      SUM(CASE WHEN face_counts.quantity = 3 THEN 1 ELSE 0 END) AS triples,
      SUM(CASE WHEN face_counts.quantity >= 4 THEN face_counts.value * 4 ELSE 0 END) AS four_kind_score
    FROM face_counts
    GROUP BY face_counts.round_id
  ),
  stats AS (
    SELECT * FROM die_stats JOIN face_stats USING (round_id)
  )
UPDATE yacht
SET result = (
  SELECT CASE
    WHEN yacht.category IN ('ones', 'twos', 'threes', 'fours', 'fives', 'sixes') THEN
      CASE yacht.category
        WHEN 'ones' THEN 1 WHEN 'twos' THEN 2 WHEN 'threes' THEN 3
        WHEN 'fours' THEN 4 WHEN 'fives' THEN 5 WHEN 'sixes' THEN 6
      END * COALESCE((
        SELECT quantity
        FROM face_counts
        WHERE face_counts.round_id = yacht.rowid
          AND face_counts.value = CASE yacht.category
            WHEN 'ones' THEN 1 WHEN 'twos' THEN 2 WHEN 'threes' THEN 3
            WHEN 'fours' THEN 4 WHEN 'fives' THEN 5 WHEN 'sixes' THEN 6
          END
      ), 0)
    WHEN yacht.category = 'full house' THEN
      CASE WHEN stats.distinct_faces = 2 AND stats.pairs = 1 AND stats.triples = 1
        THEN stats.total ELSE 0 END
    WHEN yacht.category = 'four of a kind' THEN stats.four_kind_score
    WHEN yacht.category = 'little straight' THEN
      CASE WHEN stats.dice_count = 5 AND stats.distinct_faces = 5
        AND stats.minimum = 1 AND stats.maximum = 5 THEN 30 ELSE 0 END
    WHEN yacht.category = 'big straight' THEN
      CASE WHEN stats.dice_count = 5 AND stats.distinct_faces = 5
        AND stats.minimum = 2 AND stats.maximum = 6 THEN 30 ELSE 0 END
    WHEN yacht.category = 'choice' THEN stats.total
    WHEN yacht.category = 'yacht' THEN
      CASE WHEN stats.distinct_faces = 1 THEN 50 ELSE 0 END
    ELSE 0
  END
  FROM stats
  WHERE stats.round_id = yacht.rowid
);
