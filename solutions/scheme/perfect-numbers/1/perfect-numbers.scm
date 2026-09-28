(import (rnrs))

(define (classify n)
  (assert (and (integer? n) (> n 0)))
  (let ((sum
          (if (= n 1)
              0
              (let loop ((divisor 2) (total 1))
                (if (> (* divisor divisor) n)
                    total
                    (if (= (mod n divisor) 0)
                        (let ((partner (quotient n divisor)))
                          (loop (+ divisor 1)
                                (+ total divisor
                                   (if (= partner divisor) 0 partner))))
                        (loop (+ divisor 1) total)))))))
    (cond ((= sum n) 'perfect)
          ((< sum n) 'deficient)
          (else 'abundant))))
