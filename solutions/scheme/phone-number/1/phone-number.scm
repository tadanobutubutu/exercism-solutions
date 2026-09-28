(import (rnrs))

(define (digit? ch)
  (and (char>=? ch #\0) (char<=? ch #\9)))

(define (allowed-separator? ch)
  (or (char-whitespace? ch)
      (char=? ch #\() (char=? ch #\)) (char=? ch #\-)
      (char=? ch #\.) (char=? ch #\+)))

(define (clean phone-number)
  (let ((digits
          (let loop ((remaining (string->list phone-number)) (result '()))
            (cond
              ((null? remaining) (reverse result))
              ((digit? (car remaining))
               (loop (cdr remaining) (cons (car remaining) result)))
              ((allowed-separator? (car remaining))
               (loop (cdr remaining) result))
              (else (assert #f))))))
    (let ((normalized
            (cond
              ((= (length digits) 10) digits)
              ((and (= (length digits) 11) (char=? (car digits) #\1))
               (cdr digits))
              (else (assert #f)))))
      (assert (and (not (memv (car normalized) '(#\0 #\1)))
                   (not (memv (list-ref normalized 3) '(#\0 #\1)))))
      (list->string normalized))))
