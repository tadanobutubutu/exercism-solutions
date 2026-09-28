WITH RECURSIVE
source AS (
  SELECT rowid AS id, input FROM "ocr-numbers"
),
lines(id, input, line_no, remaining, line_text) AS (
  SELECT id,
         input,
         1,
         CASE WHEN instr(input, char(10)) = 0 THEN ''
              ELSE substr(input, instr(input, char(10)) + 1) END,
         substr(input || char(10), 1, instr(input || char(10), char(10)) - 1)
    FROM source
  UNION ALL
  SELECT id,
         input,
         line_no + 1,
         CASE WHEN instr(remaining, char(10)) = 0 THEN substr(remaining, 1, 0)
              ELSE substr(remaining, instr(remaining, char(10)) + 1) END,
         substr(remaining || char(10), 1, instr(remaining || char(10), char(10)) - 1)
    FROM lines
   WHERE remaining <> ''
),
line_stats AS (
  SELECT id, COUNT(*) AS line_count,
         MAX(CASE WHEN length(line_text) % 3 <> 0 THEN 1 ELSE 0 END) AS bad_width
    FROM lines
   GROUP BY id
),
group_widths AS (
  SELECT id, (line_no - 1) / 4 AS group_no, MAX(length(line_text)) AS width
    FROM lines
   GROUP BY id, (line_no - 1) / 4
),
cells(id, group_no, cell_no, cell_count) AS (
  SELECT id, group_no, 1, width / 3 FROM group_widths WHERE width > 0
  UNION ALL
  SELECT id, group_no, cell_no + 1, cell_count
    FROM cells
   WHERE cell_no < cell_count
),
glyphs AS (
  SELECT c.id, c.group_no, c.cell_no,
         MAX(CASE WHEN (l.line_no - 1) % 4 = 0 THEN substr(l.line_text, (c.cell_no - 1) * 3 + 1, 3) END) ||
         MAX(CASE WHEN (l.line_no - 1) % 4 = 1 THEN substr(l.line_text, (c.cell_no - 1) * 3 + 1, 3) END) ||
         MAX(CASE WHEN (l.line_no - 1) % 4 = 2 THEN substr(l.line_text, (c.cell_no - 1) * 3 + 1, 3) END) ||
         MAX(CASE WHEN (l.line_no - 1) % 4 = 3 THEN substr(l.line_text, (c.cell_no - 1) * 3 + 1, 3) END) AS pattern
    FROM cells AS c
    JOIN lines AS l ON l.id = c.id AND (l.line_no - 1) / 4 = c.group_no
   GROUP BY c.id, c.group_no, c.cell_no
),
decoded AS (
  SELECT id, group_no, cell_no,
         CASE pattern
           WHEN ' _ ' || '| |' || '|_|' || '   ' THEN '0'
           WHEN '   ' || '  |' || '  |' || '   ' THEN '1'
           WHEN ' _ ' || ' _|' || '|_ ' || '   ' THEN '2'
           WHEN ' _ ' || ' _|' || ' _|' || '   ' THEN '3'
           WHEN '   ' || '|_|' || '  |' || '   ' THEN '4'
           WHEN ' _ ' || '|_ ' || ' _|' || '   ' THEN '5'
           WHEN ' _ ' || '|_ ' || '|_|' || '   ' THEN '6'
           WHEN ' _ ' || '  |' || '  |' || '   ' THEN '7'
           WHEN ' _ ' || '|_|' || '|_|' || '   ' THEN '8'
           WHEN ' _ ' || '|_|' || ' _|' || '   ' THEN '9'
           ELSE '?'
         END AS digit
    FROM glyphs
),
group_texts AS (
  SELECT DISTINCT id, group_no,
         (SELECT group_concat(digit, '')
            FROM (SELECT digit FROM decoded AS d
                   WHERE d.id = g.id AND d.group_no = g.group_no
                   ORDER BY cell_no)
         ) AS text
    FROM decoded AS g
),
answers AS (
  SELECT s.id,
         CASE
           WHEN st.line_count % 4 <> 0 THEN 'Number of input lines is not a multiple of four'
           WHEN st.bad_width = 1 THEN 'Number of input columns is not a multiple of three'
           ELSE NULL
         END AS error,
         CASE WHEN st.line_count % 4 <> 0 OR st.bad_width = 1 THEN NULL
              ELSE (SELECT group_concat(text, ',')
                      FROM (SELECT text FROM group_texts AS g
                             WHERE g.id = s.id
                             ORDER BY group_no))
          END AS result
    FROM source AS s
    JOIN line_stats AS st ON st.id = s.id
)
UPDATE "ocr-numbers"
   SET result = answers.result,
       error = answers.error
  FROM answers
 WHERE "ocr-numbers".rowid = answers.id;
