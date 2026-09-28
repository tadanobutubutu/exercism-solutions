WITH
source AS (
  SELECT rowid AS id, list_one, list_two,
         json_array_length(list_one) AS len_one,
         json_array_length(list_two) AS len_two
    FROM sublist
),
classified AS (
  SELECT s.id,
         CASE
           WHEN s.len_one = s.len_two AND json(s.list_one) = json(s.list_two) THEN 'equal'
           WHEN s.len_one <= s.len_two AND (
             s.len_one = 0 OR EXISTS (
               SELECT 1
                 FROM json_each(s.list_two) AS start
                WHERE CAST(start.key AS INTEGER) + s.len_one <= s.len_two
                  AND NOT EXISTS (
                    SELECT 1
                      FROM json_each(s.list_one) AS a
                      JOIN json_each(s.list_two) AS b
                        ON CAST(b.key AS INTEGER) = CAST(start.key AS INTEGER) + CAST(a.key AS INTEGER)
                     WHERE a.value IS NOT b.value
                  )
             )
           ) THEN 'sublist'
           WHEN s.len_two <= s.len_one AND (
             s.len_two = 0 OR EXISTS (
               SELECT 1
                 FROM json_each(s.list_one) AS start
                WHERE CAST(start.key AS INTEGER) + s.len_two <= s.len_one
                  AND NOT EXISTS (
                    SELECT 1
                      FROM json_each(s.list_two) AS b
                      JOIN json_each(s.list_one) AS a
                        ON CAST(a.key AS INTEGER) = CAST(start.key AS INTEGER) + CAST(b.key AS INTEGER)
                     WHERE a.value IS NOT b.value
                  )
             )
           ) THEN 'superlist'
           ELSE 'unequal'
         END AS result
    FROM source AS s
)
UPDATE sublist
   SET result = classified.result
  FROM classified
 WHERE sublist.rowid = classified.id;
