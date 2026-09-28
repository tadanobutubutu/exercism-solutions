WITH RECURSIVE
inputs AS (
  SELECT rowid AS id,
         CASE WHEN roll IS NULL THEN previous_rolls
              ELSE json_insert(previous_rolls, '$[#]', roll)
          END AS rolls
    FROM bowling
),
walk(id, pos, frame, ball, frame_first, tenth_first, tenth_second, finished, error) AS (
  SELECT id, 0, 1, 1, NULL, NULL, NULL, 0, NULL
    FROM inputs
  UNION ALL
  SELECT s.id,
         s.pos + 1,
         CASE
           WHEN s.error IS NOT NULL THEN s.frame
           WHEN s.frame < 10 AND s.ball = 2 THEN s.frame + 1
           WHEN s.frame < 10 AND s.ball = 1 AND CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) = 10 AND s.frame = 9 THEN 10
           WHEN s.frame < 10 AND s.ball = 1 AND CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) = 10 THEN s.frame + 1
           ELSE s.frame
         END,
         CASE
           WHEN s.error IS NOT NULL THEN s.ball
           WHEN s.frame < 10 AND s.ball = 1 AND CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) < 10 THEN 2
           WHEN s.frame < 10 THEN 1
           WHEN s.ball = 1 THEN 2
           WHEN s.ball = 2 AND (s.tenth_first = 10 OR s.tenth_first + CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) = 10) THEN 3
           WHEN s.ball = 2 THEN 1
           ELSE 1
         END,
         CASE WHEN s.error IS NULL AND s.frame < 10 AND s.ball = 1 AND CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) < 10
              THEN CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) ELSE NULL END,
         CASE WHEN s.error IS NULL AND s.frame = 10 AND s.ball = 1
              THEN CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) ELSE s.tenth_first END,
         CASE WHEN s.error IS NULL AND s.frame = 10 AND s.ball = 2
              THEN CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) ELSE s.tenth_second END,
         CASE
           WHEN s.error IS NOT NULL THEN s.finished
           WHEN s.frame = 10 AND s.ball = 2 AND s.tenth_first <> 10 AND s.tenth_first + CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) < 10 THEN 1
           WHEN s.frame = 10 AND s.ball = 3 THEN 1
           ELSE s.finished
         END,
         CASE
           WHEN s.error IS NOT NULL THEN s.error
           WHEN s.finished = 1 THEN 'Cannot roll after game is over'
           WHEN CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) < 0 THEN 'Negative roll is invalid'
           WHEN CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) > 10 THEN 'Pin count exceeds pins on the lane'
           WHEN s.frame < 10 AND s.ball = 2 AND s.frame_first + CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) > 10
             THEN 'Pin count exceeds pins on the lane'
           WHEN s.frame = 10 AND s.ball = 2 AND s.tenth_first <> 10 AND s.tenth_first + CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) > 10
             THEN 'Pin count exceeds pins on the lane'
           WHEN s.frame = 10 AND s.ball = 3 AND s.tenth_first = 10 AND s.tenth_second <> 10 AND s.tenth_second + CAST(json_extract(i.rolls, '$[' || s.pos || ']') AS INTEGER) > 10
             THEN 'Pin count exceeds pins on the lane'
           ELSE NULL
         END
    FROM walk AS s
    JOIN inputs AS i ON i.id = s.id
    WHERE s.pos < json_array_length(i.rolls)
),
score_walk(id, frame, pos, total) AS (
  SELECT id, 1, 0, 0 FROM inputs
  UNION ALL
  SELECT sw.id,
         sw.frame + 1,
         sw.pos + CASE
           WHEN CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER) = 10 THEN 1
           WHEN CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER)
                + CAST(json_extract(i.rolls, '$[' || (sw.pos + 1) || ']') AS INTEGER) = 10 THEN 2
           ELSE 2
         END,
         sw.total + CASE
           WHEN CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER) = 10
             THEN 10
                + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 1) || ']') AS INTEGER), 0)
                + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 2) || ']') AS INTEGER), 0)
           WHEN CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER)
                + CAST(json_extract(i.rolls, '$[' || (sw.pos + 1) || ']') AS INTEGER) = 10
             THEN 10 + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 2) || ']') AS INTEGER), 0)
           ELSE COALESCE(CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER), 0)
              + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 1) || ']') AS INTEGER), 0)
         END
    FROM score_walk AS sw
    JOIN inputs AS i ON i.id = sw.id
    WHERE sw.frame < 10
  UNION ALL
  SELECT sw.id, 11, sw.pos + 3,
         sw.total
         + COALESCE(CAST(json_extract(i.rolls, '$[' || sw.pos || ']') AS INTEGER), 0)
         + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 1) || ']') AS INTEGER), 0)
         + COALESCE(CAST(json_extract(i.rolls, '$[' || (sw.pos + 2) || ']') AS INTEGER), 0)
    FROM score_walk AS sw
    JOIN inputs AS i ON i.id = sw.id
    WHERE sw.frame = 10
),
final_state AS (
  SELECT id, finished, error
    FROM walk
   WHERE pos = (SELECT json_array_length(rolls) FROM inputs WHERE inputs.id = walk.id)
),
final_score AS (
  SELECT id, total FROM score_walk WHERE frame = 11
)
UPDATE bowling
   SET result = CASE
         WHEN roll IS NULL AND final_state.finished = 1 AND final_state.error IS NULL
           THEN final_score.total
         ELSE NULL
       END,
       error = CASE
         WHEN final_state.error IS NOT NULL THEN final_state.error
         WHEN roll IS NULL AND final_state.finished = 0 THEN 'Score cannot be taken until the end of the game'
         ELSE NULL
       END
  FROM final_state
  LEFT JOIN final_score ON final_score.id = final_state.id
 WHERE bowling.rowid = final_state.id;
