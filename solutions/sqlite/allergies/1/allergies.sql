-- Schema: CREATE TABLE "allergies" ("task" TEXT, "item" TEXT, "score" INT NOT NULL, "result" TEXT);
-- Task: update the bob allergies and set the result based on the task.
--       - The `allergicTo` task expects `true` or `false` based on the `score` and the `item` fields.
--       - For the `list` task you have to write corresponding items to the result field
WITH allergens(item, value, position) AS (
  VALUES
    ('eggs', 1, 1),
    ('peanuts', 2, 2),
    ('shellfish', 4, 3),
    ('strawberries', 8, 4),
    ('tomatoes', 16, 5),
    ('chocolate', 32, 6),
    ('pollen', 64, 7),
    ('cats', 128, 8)
)
UPDATE allergies
SET result = CASE task
  WHEN 'allergicTo' THEN CASE
    WHEN EXISTS (
      SELECT 1
      FROM allergens
      WHERE allergens.item = allergies.item
        AND (allergies.score & allergens.value) <> 0
    ) THEN 'true'
    ELSE 'false'
  END
  WHEN 'list' THEN COALESCE(
    (
      SELECT group_concat(item, ', ')
      FROM (
        SELECT item
        FROM allergens
        WHERE (allergies.score & allergens.value) <> 0
        ORDER BY position
      )
    ),
    ''
  )
END;
