WITH RECURSIVE
source AS (
  SELECT rowid AS id, property, string FROM "run-length-encoding"
),
encode_walk(id, input, position, current_char, run_length, output) AS (
  SELECT id, string, 1, '', 0, '' FROM source WHERE property = 'encode'
  UNION ALL
  SELECT id,
         input,
         position + 1,
         CASE WHEN current_char = '' OR substr(input, position, 1) = current_char
              THEN substr(input, position, 1)
              ELSE substr(input, position, 1) END,
         CASE WHEN current_char = '' THEN 1
              WHEN substr(input, position, 1) = current_char THEN run_length + 1
              ELSE 1 END,
         output || CASE
           WHEN current_char <> '' AND substr(input, position, 1) <> current_char
             THEN CASE WHEN run_length = 1 THEN current_char
                       ELSE CAST(run_length AS TEXT) || current_char END
           ELSE '' END
    FROM encode_walk
   WHERE position <= length(input)
),
encoded(id, result) AS (
  SELECT id,
         output || CASE WHEN run_length = 0 THEN ''
                        WHEN run_length = 1 THEN current_char
                        ELSE CAST(run_length AS TEXT) || current_char END
    FROM encode_walk
   WHERE position > length(input)
),
decode_walk(id, input, position, count_text, output, pending_char, pending_remaining) AS (
  SELECT id, string, 1, '', '', '', 0 FROM source WHERE property = 'decode'
  UNION ALL
  SELECT id,
         input,
         CASE WHEN pending_remaining > 0 THEN position ELSE position + 1 END,
         CASE WHEN pending_remaining > 0 THEN count_text
              WHEN substr(input, position, 1) GLOB '[0-9]'
                THEN count_text || substr(input, position, 1)
              ELSE '' END,
         CASE WHEN pending_remaining > 0 THEN output || pending_char
              WHEN substr(input, position, 1) GLOB '[0-9]' THEN output
              ELSE output || substr(input, position, 1) END,
         CASE WHEN pending_remaining > 0 THEN pending_char
              WHEN substr(input, position, 1) GLOB '[0-9]' THEN ''
              ELSE substr(input, position, 1) END,
         CASE WHEN pending_remaining > 0 THEN pending_remaining - 1
              WHEN substr(input, position, 1) GLOB '[0-9]' THEN 0
              WHEN count_text = '' THEN 0
              ELSE CAST(count_text AS INTEGER) - 1 END
    FROM decode_walk
   WHERE position <= length(input) OR pending_remaining > 0
),
decoded(id, result) AS (
  SELECT id, output FROM decode_walk
   WHERE position > length(input) AND pending_remaining = 0
),
answers AS (
  SELECT s.id,
         CASE WHEN s.property = 'encode' THEN e.result WHEN s.property = 'decode' THEN d.result ELSE s.string END AS result
    FROM source AS s
    LEFT JOIN encoded AS e ON e.id = s.id
    LEFT JOIN decoded AS d ON d.id = s.id
)
UPDATE "run-length-encoding"
   SET result = answers.result
  FROM answers
 WHERE "run-length-encoding".rowid = answers.id;
