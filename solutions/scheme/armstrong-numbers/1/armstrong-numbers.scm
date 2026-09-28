(import (rnrs))

(define (armstrong-number? n)
  (let* ((digits (map (lambda (c) (- (char->integer c) (char->integer #\0)))
                      (string->list (number->string n))))
         (width (length digits)))
    (= n
       (let loop ((remaining digits) (sum 0))
         (if (null? remaining)
             sum
             (loop (cdr remaining) (+ sum (expt (car remaining) width))))))))
