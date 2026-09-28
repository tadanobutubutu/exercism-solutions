(import (rnrs))

(define (factorize n)
  (assert (and (integer? n) (> n 0)))
  (let loop ((remaining n) (divisor 2) (factors '()))
    (cond
      ((= remaining 1) (reverse factors))
      ((> (* divisor divisor) remaining)
       (reverse (cons remaining factors)))
      ((= (mod remaining divisor) 0)
       (loop (quotient remaining divisor) divisor (cons divisor factors)))
      (else
       (loop remaining (if (= divisor 2) 3 (+ divisor 2)) factors)))))
