-- Schema:
-- CREATE TABLE triangle (
--     property TEXT    NOT NULL,
--     side_a   REAL    NOT NULL,
--     side_b   REAL    NOT NULL,
--     side_c   REAL    NOT NULL,
--     result   BOOLEAN
-- );
--
-- Task: update the triangle and set result based on the property, side_a, side_b and side_c columns.
UPDATE triangle
SET result = CASE
  WHEN side_a > 0
    AND side_b > 0
    AND side_c > 0
    AND side_a + side_b >= side_c
    AND side_a + side_c >= side_b
    AND side_b + side_c >= side_a
    AND CASE property
      WHEN 'equilateral' THEN side_a = side_b AND side_b = side_c
      WHEN 'isosceles' THEN side_a = side_b OR side_a = side_c OR side_b = side_c
      WHEN 'scalene' THEN side_a <> side_b AND side_a <> side_c AND side_b <> side_c
      ELSE 0
    END
  THEN 1
  ELSE 0
END;
