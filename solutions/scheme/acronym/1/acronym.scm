(import (rnrs))

(define (acronym test)
  (let ((length (string-length test)))
    (let loop ((index 0) (at-word-start? #t) (letters '()))
      (if (= index length)
          (list->string (reverse letters))
          (let ((ch (string-ref test index)))
            (if (or (char-whitespace? ch) (char=? ch #\-) (char=? ch #\_))
                (loop (+ index 1) #t letters)
                (loop (+ index 1)
                      #f
                      (if at-word-start?
                          (cons (char-upcase ch) letters)
                          letters))))))))
