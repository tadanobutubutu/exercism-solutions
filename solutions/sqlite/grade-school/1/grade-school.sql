-- Schema:
-- CREATE TABLE "grade-school" (
--   property TEXT NOT NULL,
--   input    TEXT NOT NULL,    -- json object
--   result   TEXT              -- json array
-- );
--
-- Task: update the grade-school and update the result column based on the property and the input.
WITH requests AS (
  SELECT rowid AS id, property, input
  FROM "grade-school"
), students AS (
  SELECT
    requests.id AS request_id,
    CAST(json_each.key AS INTEGER) AS position,
    json_extract(json_each.value, '$[0]') AS name,
    CAST(json_extract(json_each.value, '$[1]') AS INTEGER) AS grade
  FROM requests, json_each(requests.input, '$.students')
)
UPDATE "grade-school" AS school
SET result = CASE requests.property
  WHEN 'add' THEN (
    SELECT json_group_array(json(is_new))
    FROM (
      SELECT CASE WHEN EXISTS (
        SELECT 1 FROM students AS prior
        WHERE prior.request_id = requests.id
          AND prior.name = current.name
          AND prior.position < current.position
      ) THEN 'false' ELSE 'true' END AS is_new
      FROM students AS current
      WHERE current.request_id = requests.id
      ORDER BY current.position
    )
  )
  WHEN 'roster' THEN (
    SELECT json_group_array(name)
    FROM (
      SELECT current.name, current.grade
      FROM students AS current
      WHERE current.request_id = requests.id
        AND NOT EXISTS (
          SELECT 1 FROM students AS prior
          WHERE prior.request_id = current.request_id
            AND prior.name = current.name
            AND prior.position < current.position
        )
      ORDER BY current.grade, current.name
    )
  )
  WHEN 'grade' THEN (
    SELECT json_group_array(name)
    FROM (
      SELECT current.name
      FROM students AS current
      WHERE current.request_id = requests.id
        AND current.grade = json_extract(requests.input, '$.desiredGrade')
        AND NOT EXISTS (
          SELECT 1 FROM students AS prior
          WHERE prior.request_id = current.request_id
            AND prior.name = current.name
            AND prior.position < current.position
        )
      ORDER BY current.name
    )
  )
END
FROM requests
WHERE school.rowid = requests.id;
