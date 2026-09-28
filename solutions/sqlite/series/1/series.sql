WITH RECURSIVE
positions(id, input, slice_length, start_at) AS (
  SELECT rowid, input, slice_length, 1
    FROM series
   WHERE slice_length > 0
     AND slice_length <= length(input)
  UNION ALL
  SELECT id, input, slice_length, start_at + 1
    FROM positions
   WHERE start_at < length(input) - slice_length + 1
),
slices AS (
  SELECT id,
         group_concat(slice, char(10)) AS result
    FROM (
      SELECT id, start_at, substr(input, start_at, slice_length) AS slice
        FROM positions
       ORDER BY id, start_at
    )
   GROUP BY id
),
answers AS (
  SELECT rowid AS id,
         CASE
           WHEN slice_length < 0 THEN 'slice length cannot be negative'
           WHEN slice_length = 0 THEN 'slice length cannot be zero'
           WHEN input = '' THEN 'series cannot be empty'
           WHEN slice_length > length(input) THEN 'slice length cannot be greater than series length'
           ELSE NULL
         END AS error,
         CASE
           WHEN slice_length <= 0 OR input = '' OR slice_length > length(input) THEN NULL
           ELSE slices.result
         END AS result
    FROM series
    LEFT JOIN slices ON slices.id = series.rowid
)
UPDATE series
   SET result = answers.result,
       error = answers.error
  FROM answers
 WHERE series.rowid = answers.id;
