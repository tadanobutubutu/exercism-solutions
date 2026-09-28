(import (rnrs))

(define (sum-of-multiples ints limit)
  (let loop ((n 1) (sum 0))
    (if (>= n limit)
        sum
        (loop (+ n 1)
              (if (exists (lambda (factor)
                            (and (> factor 0) (= (mod n factor) 0)))
                          ints)
                  (+ sum n)
                  sum)))))
