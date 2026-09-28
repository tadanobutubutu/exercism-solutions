(import (rnrs))

(define (encode-letter ch)
  (if (and (char>=? ch #\a) (char<=? ch #\z))
      (integer->char (- (char->integer #\z)
                        (- (char->integer ch) (char->integer #\a))))
      ch))

(define (alphanumeric? ch)
  (or (and (char>=? ch #\a) (char<=? ch #\z))
      (and (char>=? ch #\0) (char<=? ch #\9))))

(define (join-strings strings separator)
  (if (null? strings)
      ""
      (let loop ((remaining (cdr strings)) (result (car strings)))
        (if (null? remaining)
            result
            (loop (cdr remaining)
                  (string-append result separator (car remaining)))))))

(define (group-five chars)
  (let loop ((remaining chars) (current '()) (groups '()))
    (cond
      ((null? remaining)
       (join-strings
         (reverse (if (null? current)
                      groups
                      (cons (list->string (reverse current)) groups)))
         " "))
      ((= (length current) 5)
       (loop remaining '() (cons (list->string (reverse current)) groups)))
      (else (loop (cdr remaining) (cons (car remaining) current) groups)))))

(define (encode phrase)
  (group-five
    (let loop ((remaining (string->list (string-downcase phrase))) (chars '()))
      (if (null? remaining)
          (reverse chars)
          (if (alphanumeric? (car remaining))
              (loop (cdr remaining) (cons (encode-letter (car remaining)) chars))
              (loop (cdr remaining) chars))))))

(define (decode phrase)
  (list->string
    (let loop ((remaining (string->list (string-downcase phrase))) (chars '()))
      (if (null? remaining)
          (reverse chars)
          (if (alphanumeric? (car remaining))
              (loop (cdr remaining) (cons (encode-letter (car remaining)) chars))
              (loop (cdr remaining) chars))))))
