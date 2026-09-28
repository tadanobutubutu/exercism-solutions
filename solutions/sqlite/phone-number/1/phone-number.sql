WITH RECURSIVE
scan(id, phrase, position, digits, has_letter, has_bad_character) AS (
  SELECT rowid, phrase, 1, '', 0, 0 FROM "phone-number"
  UNION ALL
  SELECT id,
         phrase,
         position + 1,
         digits || CASE WHEN substr(phrase, position, 1) GLOB '[0-9]'
                        THEN substr(phrase, position, 1) ELSE '' END,
         CASE WHEN upper(substr(phrase, position, 1)) GLOB '[A-Z]'
              THEN 1 ELSE has_letter END,
         CASE WHEN substr(phrase, position, 1) GLOB '[0-9]'
                   OR substr(phrase, position, 1) IN ('+', '(', ')', ' ', '.', '-')
              THEN has_bad_character ELSE 1 END
    FROM scan
   WHERE position <= length(phrase)
),
final AS (
  SELECT id, phrase, digits, has_letter, has_bad_character
    FROM scan
   WHERE position > length(phrase)
),
answers AS (
  SELECT id,
         CASE
           WHEN has_letter = 1 THEN 'letters not permitted'
           WHEN has_bad_character = 1 THEN 'punctuations not permitted'
           WHEN length(digits) > 11 THEN 'must not be greater than 11 digits'
           WHEN length(digits) = 11 AND substr(digits, 1, 1) <> '1' THEN '11 digits must start with 1'
           WHEN length(digits) < 10 THEN 'must not be fewer than 10 digits'
           WHEN substr(CASE WHEN length(digits) = 11 THEN substr(digits, 2) ELSE digits END, 1, 1) = '0'
             THEN 'area code cannot start with zero'
           WHEN substr(CASE WHEN length(digits) = 11 THEN substr(digits, 2) ELSE digits END, 1, 1) = '1'
             THEN 'area code cannot start with one'
           WHEN substr(CASE WHEN length(digits) = 11 THEN substr(digits, 2) ELSE digits END, 4, 1) = '0'
             THEN 'exchange code cannot start with zero'
           WHEN substr(CASE WHEN length(digits) = 11 THEN substr(digits, 2) ELSE digits END, 4, 1) = '1'
             THEN 'exchange code cannot start with one'
           ELSE NULL
         END AS error,
         CASE WHEN length(digits) = 11 AND substr(digits, 1, 1) = '1'
              THEN substr(digits, 2) ELSE digits END AS result
    FROM final
)
UPDATE "phone-number"
   SET result = CASE WHEN answers.error IS NULL THEN answers.result ELSE NULL END,
       error = answers.error
  FROM answers
 WHERE "phone-number".rowid = answers.id;
