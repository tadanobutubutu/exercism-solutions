(import (rnrs))

(define (sum-through n)
  (let loop ((i 1) (acc 0))
    (if (> i n) acc (loop (+ i 1) (+ acc i)))))

(define (square-of-sum n)
  (expt (sum-through n) 2))

(define (sum-of-squares n)
  (let loop ((i 1) (acc 0))
    (if (> i n) acc (loop (+ i 1) (+ acc (* i i))))))

(define (difference-of-squares n)
  (- (square-of-sum n) (sum-of-squares n)))


