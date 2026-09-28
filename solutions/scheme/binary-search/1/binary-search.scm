(import (rnrs))

(define (binary-search array target)
  (let loop ((low 0) (high (vector-length array)))
    (if (>= low high)
        'not-found
        (let* ((middle (+ low (quotient (- high low) 2)))
               (value (vector-ref array middle)))
          (cond
            ((= value target) middle)
            ((< value target) (loop (+ middle 1) high))
            (else (loop low middle)))))))
