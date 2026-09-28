(import (rnrs))

(define (dna->rna dna)
  (list->string
    (map (lambda (base)
           (case base
             ((#\A) #\U)
             ((#\C) #\G)
             ((#\G) #\C)
             ((#\T) #\A)
             (else (assert #f))))
         (string->list dna))))
