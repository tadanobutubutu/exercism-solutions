-- Schema: CREATE TABLE "isbn-verifier" (isbn TEXT NOT NULL, result BOOL);
-- Task: update the isbn-verifier table and set the result based on the isbn.
WITH RECURSIVE
normalized AS (
  SELECT isbn, replace(isbn, '-', '') AS digits
  FROM "isbn-verifier"
),
characters(isbn, digits, position, digit) AS (
  SELECT isbn, digits, 1, substr(digits, 1, 1)
  FROM normalized
  WHERE length(digits) > 0
  UNION ALL
  SELECT isbn, digits, position + 1, substr(digits, position + 1, 1)
  FROM characters
  WHERE position < length(digits)
),
checksums AS (
  SELECT
    isbn,
    sum(
      (CASE WHEN position = 10 AND digit = 'X' THEN 10 ELSE CAST(digit AS INTEGER) END)
      * (11 - position)
    ) AS checksum,
    sum(
      CASE
        WHEN position < 10 AND digit GLOB '[0-9]' THEN 1
        WHEN position = 10 AND (digit GLOB '[0-9]' OR digit = 'X') THEN 1
        ELSE 0
      END
    ) AS valid_digits
  FROM characters
  GROUP BY isbn
)
UPDATE "isbn-verifier" AS target
SET result = COALESCE((
  SELECT CASE
    WHEN length(normalized.digits) = 10
      AND checksums.valid_digits = 10
      AND checksums.checksum % 11 = 0 THEN 1
    ELSE 0
  END
  FROM normalized
  LEFT JOIN checksums ON checksums.isbn = normalized.isbn
  WHERE normalized.isbn = target.isbn
), 0);
