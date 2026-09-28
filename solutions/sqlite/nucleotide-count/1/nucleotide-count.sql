-- Task:  - Update the "nucleotide-count" table and set the result based on the input field.
--        - Update table creation with constraints.
DROP TABLE IF EXISTS "nucleotide-count";

CREATE TABLE "nucleotide-count" (
  "strand" TEXT NOT NULL CHECK (strand NOT GLOB '*[^ACGT]*'),
  "result" TEXT
);

-- Please don't change the following two import lines. Feel free to edit the previous lines, though.
.mode csv
.import ./data.csv "nucleotide-count"
-- Write your code below. Feel free to edit the CREATE TABLE above, too!
UPDATE "nucleotide-count"
SET result = json_object(
  'A', length(strand) - length(replace(strand, 'A', '')),
  'C', length(strand) - length(replace(strand, 'C', '')),
  'G', length(strand) - length(replace(strand, 'G', '')),
  'T', length(strand) - length(replace(strand, 'T', ''))
);
