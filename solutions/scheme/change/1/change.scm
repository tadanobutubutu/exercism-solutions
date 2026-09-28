(import (rnrs))

(define (change amount coins)
  (assert (and (integer? amount) (>= amount 0)))
  (let ((best (make-vector (+ amount 1) #f)))
    (vector-set! best 0 '())
    (let loop-amount ((current 1))
      (unless (> current amount)
        (let ((choice
                (let loop-coins ((remaining coins) (candidate #f))
                  (if (null? remaining)
                      candidate
                      (let ((coin (car remaining)))
                        (if (and (> coin 0) (<= coin current)
                                 (vector-ref best (- current coin)))
                            (let ((solution
                                    (cons coin (vector-ref best (- current coin)))))
                              (loop-coins
                                (cdr remaining)
                                (if (or (not candidate)
                                        (< (length solution) (length candidate)))
                                    solution
                                    candidate)))
                            (loop-coins (cdr remaining) candidate)))))))
          (vector-set! best current choice))
        (loop-amount (+ current 1))))
    (let ((answer (vector-ref best amount)))
      (assert answer)
      answer)))
