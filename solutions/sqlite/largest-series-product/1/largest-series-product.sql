WITH RECURSIVE
data AS (
  SELECT rowid AS id, digits, span FROM "largest-series-product"
),
starts(id, digits, span, start_at) AS (
  SELECT id, digits, span, 1
    FROM data
   WHERE span > 0
     AND span <= length(digits)
     AND digits NOT GLOB '*[^0-9]*'
  UNION ALL
  SELECT id, digits, span, start_at + 1
    FROM starts
   WHERE start_at < length(digits) - span + 1
),
products(id, start_at, span, offset, product) AS (
  SELECT id, start_at, span, 0, 1 FROM starts
  UNION ALL
  SELECT p.id, p.start_at, p.span, p.offset + 1,
         p.product * CAST(substr(s.digits, p.start_at + p.offset, 1) AS INTEGER)
    FROM products AS p
    JOIN starts AS s ON s.id = p.id AND s.start_at = p.start_at
   WHERE p.offset < p.span
),
max_products AS (
  SELECT id, MAX(product) AS result
    FROM products
   WHERE offset = span
   GROUP BY id
),
answers AS (
  SELECT d.id,
         CASE
           WHEN d.span < 0 THEN 'span must not be negative'
           WHEN d.span > length(d.digits) THEN 'span must not exceed string length'
           WHEN d.digits GLOB '*[^0-9]*' THEN 'digits input must only contain digits'
           ELSE NULL
         END AS error,
         CASE
           WHEN d.span < 0 OR d.span > length(d.digits) OR d.digits GLOB '*[^0-9]*' THEN NULL
           WHEN d.span = 0 THEN 1
           ELSE m.result
         END AS result
    FROM data AS d
    LEFT JOIN max_products AS m ON m.id = d.id
)
UPDATE "largest-series-product"
   SET result = answers.result,
       error = answers.error
  FROM answers
 WHERE "largest-series-product".rowid = answers.id;
