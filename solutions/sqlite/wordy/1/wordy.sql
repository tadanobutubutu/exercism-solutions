WITH RECURSIVE
source AS (
  SELECT rowid AS id,
         question,
         substr(question, 1, 7) = 'What is' AS is_math,
         substr(question, 1, 8) = 'What is ' AND substr(question, -1, 1) = '?' AS valid_wrapper,
         CASE WHEN substr(question, 1, 8) = 'What is ' AND substr(question, -1, 1) = '?'
              THEN trim(substr(question, 9, length(question) - 9))
              ELSE '' END AS body
    FROM wordy
),
raw_tokens(id, token_no, token, rest) AS (
  SELECT id,
         1,
         substr(body || ' ', 1, instr(body || ' ', ' ') - 1),
         substr(body || ' ', instr(body || ' ', ' ') + 1)
    FROM source
   WHERE body <> ''
  UNION ALL
  SELECT id,
         token_no + 1,
         substr(rest, 1, instr(rest, ' ') - 1),
         substr(rest, instr(rest, ' ') + 1)
    FROM raw_tokens
   WHERE rest <> ''
),
logical_tokens AS (
  SELECT t.id,
         ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.token_no) AS position,
         CASE WHEN t.token IN ('multiplied', 'divided') AND n.token = 'by'
              THEN t.token || ' by'
              ELSE t.token END AS token
    FROM raw_tokens AS t
    LEFT JOIN raw_tokens AS n ON n.id = t.id AND n.token_no = t.token_no + 1
   WHERE NOT (
     t.token = 'by'
     AND EXISTS (
       SELECT 1 FROM raw_tokens AS p
        WHERE p.id = t.id AND p.token_no = t.token_no - 1
          AND p.token IN ('multiplied', 'divided')
     )
   )
),
annotated AS (
  SELECT id, position, token,
         CASE
           WHEN token <> '' AND token NOT GLOB '*[^0-9]*' THEN 1
           WHEN substr(token, 1, 1) = '-'
            AND length(token) > 1
            AND substr(token, 2) NOT GLOB '*[^0-9]*' THEN 1
           ELSE 0
         END AS is_number
    FROM logical_tokens
),
flags AS (
  SELECT s.id,
         s.is_math,
         s.valid_wrapper,
         COUNT(a.position) AS token_count,
         MAX(CASE WHEN a.position % 2 = 0
                   AND a.is_number = 0
                   AND a.token NOT IN ('plus', 'minus', 'multiplied by', 'divided by', 'multiplied', 'divided')
                  THEN 1 ELSE 0 END) AS unknown_operation,
         MAX(CASE WHEN a.position % 2 = 0 AND a.token IN ('multiplied', 'divided')
                  THEN 1 ELSE 0 END) AS malformed_multiword_op,
         MAX(CASE WHEN a.position % 2 = 1 AND a.is_number = 0
                  THEN 1 ELSE 0 END) AS bad_operand,
         MAX(CASE WHEN a.position % 2 = 0 AND a.is_number = 1
                  THEN 1 ELSE 0 END) AS number_in_operator_position
    FROM source AS s
    LEFT JOIN annotated AS a ON a.id = s.id
   GROUP BY s.id, s.is_math, s.valid_wrapper
),
errors AS (
  SELECT id,
         CASE
           WHEN is_math = 0 THEN 'unknown operation'
           WHEN valid_wrapper = 0 THEN 'syntax error'
           WHEN unknown_operation = 1 THEN 'unknown operation'
           WHEN token_count = 0 OR token_count % 2 = 0
             OR malformed_multiword_op = 1 OR bad_operand = 1
             OR number_in_operator_position = 1 THEN 'syntax error'
           ELSE NULL
         END AS error
    FROM flags
),
evaluation(id, step, value) AS (
  SELECT a.id, 1, CAST(a.token AS INTEGER)
    FROM annotated AS a
    JOIN errors AS e ON e.id = a.id AND e.error IS NULL
   WHERE a.position = 1 AND a.is_number = 1
  UNION ALL
  SELECT ev.id,
         ev.step + 1,
         CASE op.token
           WHEN 'plus' THEN ev.value + CAST(number.token AS INTEGER)
           WHEN 'minus' THEN ev.value - CAST(number.token AS INTEGER)
           WHEN 'multiplied by' THEN ev.value * CAST(number.token AS INTEGER)
           WHEN 'divided by' THEN ev.value / CAST(number.token AS INTEGER)
         END
    FROM evaluation AS ev
    JOIN annotated AS op ON op.id = ev.id AND op.position = ev.step * 2
    JOIN annotated AS number ON number.id = ev.id AND number.position = ev.step * 2 + 1
   WHERE op.token IN ('plus', 'minus', 'multiplied by', 'divided by')
),
final AS (
  SELECT ev.id, ev.value
    FROM evaluation AS ev
    JOIN flags AS f ON f.id = ev.id
   WHERE ev.step = (f.token_count + 1) / 2
)
UPDATE wordy
   SET error = errors.error,
       result = CASE WHEN errors.error IS NULL THEN final.value ELSE NULL END
  FROM errors
  LEFT JOIN final ON final.id = errors.id
 WHERE wordy.rowid = errors.id;
