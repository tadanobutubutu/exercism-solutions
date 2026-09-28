WITH RECURSIVE
  numbers(value) AS (
    VALUES (0)
    UNION ALL
    SELECT value + 1 FROM numbers WHERE value < 50
  ),
  diamond_rows(letter, center, row_number) AS (
    SELECT
      diamond.letter,
      unicode(diamond.letter) - unicode('A'),
      numbers.value
    FROM diamond
    CROSS JOIN numbers
    WHERE numbers.value <= 2 * (unicode(diamond.letter) - unicode('A'))
  ),
  rendered AS (
    SELECT
      letter,
      row_number,
      CASE
        WHEN row_number <= center THEN row_number
        ELSE center * 2 - row_number
      END AS level,
      center
    FROM diamond_rows
  ),
  lines AS (
    SELECT
      letter,
      row_number,
      substr('                                                  ', 1, center - level)
        || char(unicode('A') + level)
        || CASE WHEN level = 0 THEN ''
          ELSE substr('                                                  ', 1, 2 * level - 1)
            || char(unicode('A') + level)
        END
        || substr('                                                  ', 1, center - level) AS line
    FROM rendered
  )
UPDATE diamond
SET result = (
  SELECT group_concat(line, char(10))
  FROM (
    SELECT lines.line
    FROM lines
    WHERE lines.letter = diamond.letter
    ORDER BY lines.row_number
  )
);
