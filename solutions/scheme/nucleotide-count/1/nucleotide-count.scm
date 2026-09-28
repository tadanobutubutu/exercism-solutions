(import (rnrs))

(define (nucleotide-count dna)
  (let ((counts (make-vector 4 0)))
    (for-each
      (lambda (base)
        (let ((index
                (case base
                  ((#\A) 0)
                  ((#\C) 1)
                  ((#\G) 2)
                  ((#\T) 3)
                  (else (assert #f)))))
          (vector-set! counts index (+ 1 (vector-ref counts index)))))
      (string->list dna))
    (list (cons #\A (vector-ref counts 0))
          (cons #\C (vector-ref counts 1))
          (cons #\G (vector-ref counts 2))
          (cons #\T (vector-ref counts 3)))))
