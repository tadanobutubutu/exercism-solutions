(import (rnrs))

(define (next-row row)
  (let loop ((remaining row) (result '(1)))
    (if (null? (cdr remaining))
        (reverse (cons 1 result))
        (loop (cdr remaining)
              (cons (+ (car remaining) (cadr remaining)) result)))))

(define (pascals-triangle n)
  (assert (and (integer? n) (>= n 0)))
  (let loop ((remaining n) (row '(1)) (rows '()))
    (if (= remaining 0)
        (reverse rows)
        (loop (- remaining 1) (next-row row) (cons row rows)))))

