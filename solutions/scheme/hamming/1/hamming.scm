(import (rnrs))

(define (hamming-distance strand-a strand-b)
  (assert (= (string-length strand-a) (string-length strand-b)))
  (let loop ((i 0) (distance 0))
    (if (= i (string-length strand-a))
        distance
        (loop (+ i 1)
              (if (char=? (string-ref strand-a i)
                          (string-ref strand-b i))
                  distance
                  (+ distance 1))))))
