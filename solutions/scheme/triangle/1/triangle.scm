(import (rnrs))

(define (triangle a b c)
  (assert (and (> a 0) (> b 0) (> c 0)
               (> (+ a b) c) (> (+ a c) b) (> (+ b c) a)))
  (cond
    ((and (= a b) (= b c)) 'equilateral)
    ((or (= a b) (= a c) (= b c)) 'isosceles)
    (else 'scalene)))
