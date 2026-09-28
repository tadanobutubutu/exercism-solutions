(import (rnrs))

(define (keep pred seq)
  (let loop ((remaining seq) (result '()))
    (if (null? remaining)
        (reverse result)
        (loop (cdr remaining)
              (if (pred (car remaining))
                  (cons (car remaining) result)
                  result)))))

(define (discard pred seq)
  (let loop ((remaining seq) (result '()))
    (if (null? remaining)
        (reverse result)
        (loop (cdr remaining)
              (if (pred (car remaining))
                  result
                  (cons (car remaining) result))))))
