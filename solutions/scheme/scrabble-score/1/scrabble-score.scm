(import (rnrs))

(define (score word)
  (let ((points
          '((#\A . 1) (#\E . 1) (#\I . 1) (#\O . 1) (#\U . 1)
            (#\L . 1) (#\N . 1) (#\R . 1) (#\S . 1) (#\T . 1)
            (#\D . 2) (#\G . 2)
            (#\B . 3) (#\C . 3) (#\M . 3) (#\P . 3)
            (#\F . 4) (#\H . 4) (#\V . 4) (#\W . 4) (#\Y . 4)
            (#\K . 5)
            (#\J . 8) (#\X . 8)
            (#\Q . 10) (#\Z . 10))))
    (let loop ((letters (string->list (string-upcase word))) (sum 0))
      (if (null? letters)
          sum
          (let ((entry (assv (car letters) points)))
            (loop (cdr letters) (+ sum (if entry (cdr entry) 0))))))))
