WITH RECURSIVE
walk(id, strand, position, proteins, error, stopped) AS (
  SELECT rowid, strand, 1, '', NULL, 0 FROM "protein-translation"
  UNION ALL
  SELECT id,
         strand,
         position + 3,
         CASE
           WHEN length(strand) - position + 1 < 3 THEN proteins
           WHEN substr(strand, position, 3) IN ('UAA', 'UAG', 'UGA') THEN proteins
           WHEN substr(strand, position, 3) IN ('AUG')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Methionine'
           WHEN substr(strand, position, 3) IN ('UUU', 'UUC')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Phenylalanine'
           WHEN substr(strand, position, 3) IN ('UUA', 'UUG')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Leucine'
           WHEN substr(strand, position, 3) IN ('UCU', 'UCC', 'UCA', 'UCG')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Serine'
           WHEN substr(strand, position, 3) IN ('UAU', 'UAC')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Tyrosine'
           WHEN substr(strand, position, 3) IN ('UGU', 'UGC')
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Cysteine'
           WHEN substr(strand, position, 3) = 'UGG'
             THEN proteins || CASE WHEN proteins = '' THEN '' ELSE ', ' END || 'Tryptophan'
           ELSE proteins
         END,
         CASE
           WHEN length(strand) - position + 1 < 3 THEN 'Invalid codon'
           WHEN substr(strand, position, 3) IN (
             'UAA','UAG','UGA','AUG','UUU','UUC','UUA','UUG',
             'UCU','UCC','UCA','UCG','UAU','UAC','UGU','UGC','UGG'
           ) THEN error
           ELSE 'Invalid codon'
         END,
         CASE
           WHEN length(strand) - position + 1 < 3 THEN 1
           WHEN substr(strand, position, 3) IN ('UAA', 'UAG', 'UGA') THEN 1
           WHEN substr(strand, position, 3) NOT IN (
             'AUG','UUU','UUC','UUA','UUG','UCU','UCC','UCA','UCG',
             'UAU','UAC','UGU','UGC','UGG'
           ) THEN 1
           ELSE 0
         END
    FROM walk
   WHERE position <= length(strand)
     AND stopped = 0
),
final AS (
  SELECT id, proteins, error FROM walk
   WHERE position > length(strand) OR stopped = 1
)
UPDATE "protein-translation"
   SET result = CASE WHEN final.error IS NULL THEN final.proteins ELSE NULL END,
       error = final.error
  FROM final
 WHERE "protein-translation".rowid = final.id;
