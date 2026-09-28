(import (rnrs))

(define (all-whitespace? message)
  (let loop ((chars (string->list message)))
    (or (null? chars)
        (and (char-whitespace? (car chars)) (loop (cdr chars))))))

(define (has-letter? message)
  (let loop ((chars (string->list message)))
    (and (not (null? chars))
         (or (char-alphabetic? (car chars)) (loop (cdr chars))))))

(define (shouting? message)
  (and (has-letter? message)
       (let loop ((chars (string->list message)))
         (or (null? chars)
             (and (or (not (char-alphabetic? (car chars)))
                      (char-upper-case? (car chars)))
                  (loop (cdr chars)))))))

(define (question? message)
  (let loop ((index (- (string-length message) 1)))
    (if (< index 0)
        #f
        (let ((ch (string-ref message index)))
          (if (char-whitespace? ch)
              (loop (- index 1))
              (char=? ch #\?))))))

(define (response-for message)
  (cond
    ((all-whitespace? message) "Fine. Be that way!")
    ((and (shouting? message) (question? message))
     "Calm down, I know what I'm doing!")
    ((shouting? message) "Whoa, chill out!")
    ((question? message) "Sure.")
    (else "Whatever.")))
