(import (rnrs))

(define (transpose matrix)
  (if (null? matrix)
      '()
      (let ((width (apply max (map length matrix))))
        (let columns ((index 0) (result '()))
          (if (= index width)
              (reverse result)
              (columns
                (+ index 1)
                (cons
                  (map (lambda (row)
                         (if (< index (length row))
                             (list-ref row index)
                             32))
                       matrix)
                  result)))))))
