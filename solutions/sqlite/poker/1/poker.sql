WITH RECURSIVE
  hands AS (
    SELECT
      poker.rowid AS request_id,
      CAST(hand.key AS INTEGER) AS hand_index,
      hand.value AS hand
    FROM poker
    CROSS JOIN json_each(poker.hands) AS hand
  ),
  card_parts(request_id, hand_index, hand, remaining, card) AS (
    SELECT
      request_id,
      hand_index,
      hand,
      hand || ' ',
      ''
    FROM hands
    UNION ALL
    SELECT
      request_id,
      hand_index,
      hand,
      substr(remaining, instr(remaining, ' ') + 1),
      substr(remaining, 1, instr(remaining, ' ') - 1)
    FROM card_parts
    WHERE remaining <> ''
  ),
  cards AS (
    SELECT
      request_id,
      hand_index,
      hand,
      CASE substr(card, 1, length(card) - 1)
        WHEN 'J' THEN 11 WHEN 'Q' THEN 12 WHEN 'K' THEN 13 WHEN 'A' THEN 14
        ELSE CAST(substr(card, 1, length(card) - 1) AS INTEGER)
      END AS value,
      substr(card, -1, 1) AS suit
    FROM card_parts
    WHERE card <> ''
  ),
  rank_counts AS (
    SELECT request_id, hand_index, value, COUNT(*) AS quantity
    FROM cards
    GROUP BY request_id, hand_index, value
  ),
  hand_stats AS (
    SELECT
      cards.request_id,
      cards.hand_index,
      cards.hand,
      COUNT(*) AS card_count,
      COUNT(DISTINCT cards.value) AS distinct_ranks,
      COUNT(DISTINCT cards.suit) AS distinct_suits,
      MIN(cards.value) AS low_rank,
      MAX(cards.value) AS high_rank
    FROM cards
    GROUP BY cards.request_id, cards.hand_index, cards.hand
  ),
  profiles AS (
    SELECT
      hand_stats.*,
      COALESCE((
        SELECT group_concat(printf('%02d', ordered.value), '')
        FROM (
          SELECT value FROM cards
          WHERE cards.request_id = hand_stats.request_id
            AND cards.hand_index = hand_stats.hand_index
          ORDER BY value DESC
        ) AS ordered
      ), '') AS ranks_desc,
      COALESCE((
        SELECT group_concat(printf('%02d', ordered.value), '')
        FROM (
          SELECT value FROM rank_counts
          WHERE rank_counts.request_id = hand_stats.request_id
            AND rank_counts.hand_index = hand_stats.hand_index
            AND quantity = 1
          ORDER BY value DESC
        ) AS ordered
      ), '') AS singles_desc,
      COALESCE((
        SELECT group_concat(printf('%02d', ordered.value), '')
        FROM (
          SELECT value FROM rank_counts
          WHERE rank_counts.request_id = hand_stats.request_id
            AND rank_counts.hand_index = hand_stats.hand_index
            AND quantity = 2
          ORDER BY value DESC
        ) AS ordered
      ), '') AS pairs_desc,
      COALESCE((
        SELECT printf('%02d', value) FROM rank_counts
        WHERE rank_counts.request_id = hand_stats.request_id
          AND rank_counts.hand_index = hand_stats.hand_index
          AND quantity = 3
      ), '') AS trips,
      COALESCE((
        SELECT printf('%02d', value) FROM rank_counts
        WHERE rank_counts.request_id = hand_stats.request_id
          AND rank_counts.hand_index = hand_stats.hand_index
          AND quantity = 4
      ), '') AS quads,
      CASE
        WHEN hand_stats.distinct_ranks = 5
          AND EXISTS (
            SELECT 1 FROM rank_counts
            WHERE rank_counts.request_id = hand_stats.request_id
              AND rank_counts.hand_index = hand_stats.hand_index
              AND value = 14
          )
          AND EXISTS (
            SELECT 1 FROM rank_counts
            WHERE rank_counts.request_id = hand_stats.request_id
              AND rank_counts.hand_index = hand_stats.hand_index
              AND value = 2
          )
          AND EXISTS (
            SELECT 1 FROM rank_counts
            WHERE rank_counts.request_id = hand_stats.request_id
              AND rank_counts.hand_index = hand_stats.hand_index
              AND value = 3
          )
          AND EXISTS (
            SELECT 1 FROM rank_counts
            WHERE rank_counts.request_id = hand_stats.request_id
              AND rank_counts.hand_index = hand_stats.hand_index
              AND value = 4
          )
          AND EXISTS (
            SELECT 1 FROM rank_counts
            WHERE rank_counts.request_id = hand_stats.request_id
              AND rank_counts.hand_index = hand_stats.hand_index
              AND value = 5
          ) THEN 5
        WHEN hand_stats.distinct_ranks = 5
          AND hand_stats.high_rank - hand_stats.low_rank = 4
          THEN hand_stats.high_rank
        ELSE 0
      END AS straight_high
    FROM hand_stats
  ),
  scores AS (
    SELECT
      profiles.request_id,
      profiles.hand_index,
      profiles.hand,
      CASE
        WHEN profiles.distinct_suits = 1 AND profiles.straight_high > 0
          THEN '8' || printf('%02d', profiles.straight_high)
        WHEN profiles.quads <> ''
          THEN '7' || profiles.quads || profiles.singles_desc
        WHEN profiles.trips <> '' AND profiles.pairs_desc <> ''
          THEN '6' || profiles.trips || profiles.pairs_desc
        WHEN profiles.distinct_suits = 1
          THEN '5' || profiles.ranks_desc
        WHEN profiles.straight_high > 0
          THEN '4' || printf('%02d', profiles.straight_high)
        WHEN profiles.trips <> ''
          THEN '3' || profiles.trips || profiles.singles_desc
        WHEN length(profiles.pairs_desc) = 4
          THEN '2' || profiles.pairs_desc || profiles.singles_desc
        WHEN profiles.pairs_desc <> ''
          THEN '1' || profiles.pairs_desc || profiles.singles_desc
        ELSE '0' || profiles.ranks_desc
      END AS score
    FROM profiles
  ),
  best AS (
    SELECT request_id, MAX(score) AS score
    FROM scores
    GROUP BY request_id
  )
UPDATE poker
SET result = (
  SELECT json_group_array(winners.hand)
  FROM (
    SELECT scores.hand
    FROM scores
    JOIN best USING (request_id, score)
    WHERE scores.request_id = poker.rowid
    ORDER BY scores.hand_index
  ) AS winners
);
