(import (rnrs))

(define (square n)
  (assert (and (integer? n) (<= 1 n 64)))
  (expt 2 (- n 1)))

(define total
  (- (expt 2 64) 1))
