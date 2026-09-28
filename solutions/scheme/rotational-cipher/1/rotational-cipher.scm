(import (rnrs))

(define (rotate phrase dx)
  (let ((shift (mod dx 26)))
    (list->string
      (map (lambda (ch)
             (cond
               ((and (char>=? ch #\a) (char<=? ch #\z))
                (integer->char (+ (char->integer #\a)
                                  (mod (+ (- (char->integer ch) (char->integer #\a)) shift) 26))))
               ((and (char>=? ch #\A) (char<=? ch #\Z))
                (integer->char (+ (char->integer #\A)
                                  (mod (+ (- (char->integer ch) (char->integer #\A)) shift) 26))))
               (else ch)))
           (string->list phrase)))))
