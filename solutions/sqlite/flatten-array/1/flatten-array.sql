-- Schema:
-- CREATE TABLE "flatten-array" (
--   array  TEXT NOT NULL,    -- json array
--   result TEXT              -- json array
-- );
UPDATE "flatten-array"
SET result = (
  SELECT json_group_array(
    json(
      CASE type
        WHEN 'true' THEN 'true'
        WHEN 'false' THEN 'false'
        ELSE json_quote(value)
      END
    )
  )
  FROM json_tree("flatten-array".array)
  WHERE type NOT IN ('array', 'object', 'null')
  ORDER BY id
);
