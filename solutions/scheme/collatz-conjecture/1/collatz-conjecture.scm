(import (rnrs))

(define (collatz n)
  (assert (and (integer? n) (> n 0)))
  (let loop ((current n) (steps 0))
    (if (= current 1)
        steps
        (loop (if (even? current) (/ current 2) (+ (* 3 current) 1))
              (+ steps 1)))))
