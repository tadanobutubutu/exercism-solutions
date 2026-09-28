(import (rnrs))

(define (gcd a b)
  (if (= b 0) (abs a) (gcd b (mod a b))))

(define (valid-key? key)
  (and (pair? key)
       (integer? (car key))
       (integer? (cdr key))
       (= (gcd (car key) 26) 1)))

(define (modular-inverse a)
  (let loop ((candidate 1))
    (if (= (mod (* a candidate) 26) 1)
        candidate
        (loop (+ candidate 1)))))

(define (letter? ch)
  (and (char>=? ch #\a) (char<=? ch #\z)))

(define (digit? ch)
  (and (char>=? ch #\0) (char<=? ch #\9)))

(define (group-five chars)
  (let loop ((remaining chars) (current '()) (groups '()))
    (cond
      ((null? remaining)
       (join-strings (reverse (if (null? current)
                                 groups
                                 (cons (list->string (reverse current)) groups)))
                     " "))
      ((= (length current) 5)
       (loop remaining '() (cons (list->string (reverse current)) groups)))
      (else (loop (cdr remaining) (cons (car remaining) current) groups)))))

(define (join-strings strings separator)
  (if (null? strings)
      ""
      (let loop ((remaining (cdr strings)) (result (car strings)))
        (if (null? remaining)
            result
            (loop (cdr remaining)
                  (string-append result separator (car remaining)))))))

(define (encode-char a b ch)
  (let ((index (- (char->integer ch) (char->integer #\a))))
    (integer->char (+ (char->integer #\a) (mod (+ (* a index) b) 26)))))

(define (decode-char a b ch)
  (let ((index (- (char->integer ch) (char->integer #\a)))
        (inverse (modular-inverse a)))
    (integer->char (+ (char->integer #\a) (mod (* inverse (- index b)) 26)))))

(define (encode key text)
  (assert (valid-key? key))
  (let ((a (mod (car key) 26)) (b (mod (cdr key) 26)))
    (group-five
      (let loop ((remaining (string->list (string-downcase text))) (result '()))
        (if (null? remaining)
            (reverse result)
            (let ((ch (car remaining)))
              (cond
                ((letter? ch) (loop (cdr remaining) (cons (encode-char a b ch) result)))
                ((digit? ch) (loop (cdr remaining) (cons ch result)))
                (else (loop (cdr remaining) result)))))))))

(define (decode key text)
  (assert (valid-key? key))
  (let ((a (mod (car key) 26)) (b (mod (cdr key) 26)))
    (list->string
      (let loop ((remaining (string->list (string-downcase text))) (result '()))
        (if (null? remaining)
            (reverse result)
            (let ((ch (car remaining)))
              (cond
                ((letter? ch) (loop (cdr remaining) (cons (decode-char a b ch) result)))
                ((digit? ch) (loop (cdr remaining) (cons ch result)))
                (else (loop (cdr remaining) result)))))))))
