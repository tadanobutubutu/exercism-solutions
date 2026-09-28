-- Schema: CREATE TABLE "kindergarten-garden" ("diagram" TEXT, "student" TEXT, "result" TEXT);
-- Task: update the kindergarten-garden table and set the result based on the diagram and student fields.
WITH students(name, position) AS (
  VALUES
    ('Alice', 0), ('Bob', 1), ('Charlie', 2), ('David', 3),
    ('Eve', 4), ('Fred', 5), ('Ginny', 6), ('Harriet', 7),
    ('Ileana', 8), ('Joseph', 9), ('Kincaid', 10), ('Larry', 11)
)
UPDATE "kindergarten-garden"
SET result = (
  SELECT
    CASE substr(diagram, 2 * students.position + 1, 1)
      WHEN 'V' THEN 'violets' WHEN 'C' THEN 'clover'
      WHEN 'R' THEN 'radishes' WHEN 'G' THEN 'grass' END || ',' ||
    CASE substr(diagram, 2 * students.position + 2, 1)
      WHEN 'V' THEN 'violets' WHEN 'C' THEN 'clover'
      WHEN 'R' THEN 'radishes' WHEN 'G' THEN 'grass' END || ',' ||
    CASE substr(diagram, instr(diagram, char(10)) + 2 * students.position + 1, 1)
      WHEN 'V' THEN 'violets' WHEN 'C' THEN 'clover'
      WHEN 'R' THEN 'radishes' WHEN 'G' THEN 'grass' END || ',' ||
    CASE substr(diagram, instr(diagram, char(10)) + 2 * students.position + 2, 1)
      WHEN 'V' THEN 'violets' WHEN 'C' THEN 'clover'
      WHEN 'R' THEN 'radishes' WHEN 'G' THEN 'grass' END
  FROM students
  WHERE students.name = "kindergarten-garden".student
);
