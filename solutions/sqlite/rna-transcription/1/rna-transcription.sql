-- Schema: CREATE TABLE "rna-transcription" ("dna" TEXT, "result" TEXT);
-- Task: update the rna-transcription table and set the result based on the dna field.
UPDATE "rna-transcription"
SET result = upper(
  replace(
    replace(
      replace(
        replace(dna, 'A', 'u'),
        'C', 'g'
      ),
      'G', 'c'
    ),
    'T', 'a'
  )
);
