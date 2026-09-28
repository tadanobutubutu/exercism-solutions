(import (rnrs))

(define (word-character? ch)
  (or (and (char>=? ch #\a) (char<=? ch #\z))
      (and (char>=? ch #\0) (char<=? ch #\9))))

(define (record-word counts word)
  (let loop ((before '()) (remaining counts))
    (cond
      ((null? remaining)
       (reverse (cons (cons word 1) before)))
      ((string=? word (caar remaining))
       (append (reverse before)
               (cons (cons word (+ 1 (cdar remaining))) (cdr remaining))))
      (else (loop (cons (car remaining) before) (cdr remaining))))))

(define (word-count sentence)
  (let ((chars (string->list (string-downcase sentence))))
    (let scan ((remaining chars) (current '()) (counts '()))
      (cond
        ((null? remaining)
         (if (null? current)
             counts
             (record-word counts (list->string (reverse current)))))
        ((word-character? (car remaining))
         (scan (cdr remaining) (cons (car remaining) current) counts))
        ((and (char=? (car remaining) #\')
              (not (null? current))
              (not (null? (cdr remaining)))
              (word-character? (cadr remaining)))
         (scan (cdr remaining) (cons #\' current) counts))
        (else
         (scan (cdr remaining)
               '()
               (if (null? current)
                   counts
                   (record-word counts (list->string (reverse current))))))))))
