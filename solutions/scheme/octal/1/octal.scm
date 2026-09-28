(import (rnrs))

(define (to-decimal s)
  (let loop ((index 0) (value 0))
    (if (= index (string-length s))
        value
        (let ((ch (string-ref s index)))
          (if (and (char>=? ch #\0) (char<=? ch #\7))
              (loop (+ index 1)
                    (+ (* value 8) (- (char->integer ch) (char->integer #\0))))
              0)))))
