WITH RECURSIVE
source AS (
  SELECT rowid AS id, property, input,
         json_extract(input, '$.instructions') AS instructions
    FROM "robot-simulator"
),
walk(id, input, instructions, position, x, y, direction) AS (
  SELECT id,
         input,
         instructions,
         1,
         CAST(json_extract(input, '$.position.x') AS INTEGER),
         CAST(json_extract(input, '$.position.y') AS INTEGER),
         CASE json_extract(input, '$.direction')
           WHEN 'north' THEN 0
           WHEN 'east' THEN 1
           WHEN 'south' THEN 2
           ELSE 3
         END
    FROM source
   WHERE property = 'move'
  UNION ALL
  SELECT id,
         input,
         instructions,
         position + 1,
         x + CASE WHEN substr(instructions, position, 1) = 'A' AND direction = 1 THEN 1
                  WHEN substr(instructions, position, 1) = 'A' AND direction = 3 THEN -1
                  ELSE 0 END,
         y + CASE WHEN substr(instructions, position, 1) = 'A' AND direction = 0 THEN 1
                  WHEN substr(instructions, position, 1) = 'A' AND direction = 2 THEN -1
                  ELSE 0 END,
         CASE substr(instructions, position, 1)
           WHEN 'R' THEN (direction + 1) % 4
           WHEN 'L' THEN (direction + 3) % 4
           ELSE direction
         END
    FROM walk
   WHERE position <= length(instructions)
),
final AS (
  SELECT id, x, y, direction FROM walk
   WHERE position > length(instructions)
),
answers AS (
  SELECT s.id,
         CASE WHEN s.property = 'create' THEN json(s.input)
              ELSE json_object(
                'position', json_object('x', f.x, 'y', f.y),
                'direction', CASE f.direction
                  WHEN 0 THEN 'north'
                  WHEN 1 THEN 'east'
                  WHEN 2 THEN 'south'
                  ELSE 'west' END
              )
          END AS result
    FROM source AS s
    LEFT JOIN final AS f ON f.id = s.id
)
UPDATE "robot-simulator"
   SET result = answers.result
  FROM answers
 WHERE "robot-simulator".rowid = answers.id;
