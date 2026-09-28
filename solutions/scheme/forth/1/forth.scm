
(define (forth program)
  (define (tokenize text)
    (let loop ((remaining (string->list text)) (current '()) (tokens '()))
      (cond
        ((null? remaining)
         (reverse (if (null? current)
                      tokens
                      (cons (list->string (reverse current)) tokens))))
        ((char-whitespace? (car remaining))
         (loop (cdr remaining)
               '()
               (if (null? current)
                   tokens
                   (cons (list->string (reverse current)) tokens))))
        (else (loop (cdr remaining) (cons (car remaining) current) tokens)))))

  (define (built-in name)
    (cond ((string=? name "+") 'add)
          ((string=? name "-") 'subtract)
          ((string=? name "*") 'multiply)
          ((string=? name "/") 'divide)
          ((string=? name "dup") 'dup)
          ((string=? name "drop") 'drop)
          ((string=? name "swap") 'swap)
          ((string=? name "over") 'over)
          (else #f)))

  (define (compile-token token dictionary)
    (let* ((name (string-downcase token))
           (number (string->number name))
           (user-word (assoc name dictionary)))
      (cond
        ((and number (integer? number)) number)
        (user-word (vector 'user (cdr user-word)))
        ((built-in name) => (lambda (instruction) instruction))
        (else (assert #f)))))

  (define (compile-definition tokens dictionary)
    (map (lambda (token) (compile-token token dictionary)) tokens))

  (define (take-definition tokens reversed)
    (cond
      ((null? tokens) (assert #f))
      ((string=? (car tokens) ";")
       (values (reverse reversed) (cdr tokens)))
      (else (take-definition (cdr tokens) (cons (car tokens) reversed)))))

  (define (execute-primitive instruction stack)
    (cond
      ((or (eq? instruction 'add) (eq? instruction 'subtract)
           (eq? instruction 'multiply) (eq? instruction 'divide))
       (assert (and (pair? stack) (pair? (cdr stack))))
       (let ((right (car stack)) (left (cadr stack)) (rest (cddr stack)))
         (cons
           (cond
             ((eq? instruction 'add) (+ left right))
             ((eq? instruction 'subtract) (- left right))
             ((eq? instruction 'multiply) (* left right))
             ((eq? instruction 'divide)
              (assert (not (= right 0)))
              (quotient left right)))
           rest)))
      ((eq? instruction 'dup)
       (assert (pair? stack))
       (cons (car stack) stack))
      ((eq? instruction 'drop)
       (assert (pair? stack))
       (cdr stack))
      ((eq? instruction 'swap)
       (assert (and (pair? stack) (pair? (cdr stack))))
       (cons (cadr stack) (cons (car stack) (cddr stack))))
      ((eq? instruction 'over)
       (assert (and (pair? stack) (pair? (cdr stack))))
       (cons (cadr stack) stack))
      (else (assert #f))))

  (define (execute instructions stack)
    (let loop ((remaining instructions) (current-stack stack))
      (if (null? remaining)
          current-stack
          (let ((instruction (car remaining)))
            (loop (cdr remaining)
                  (cond
                    ((number? instruction) (cons instruction current-stack))
                    ((symbol? instruction)
                     (execute-primitive instruction current-stack))
                    (else
                     (execute (vector-ref instruction 1) current-stack))))))))

  (let ((tokens (apply append (map tokenize program))))
    (let run ((remaining tokens) (dictionary '()) (stack '()))
      (if (null? remaining)
          stack
          (if (string=? (car remaining) ":")
              (begin
                (assert (and (pair? (cdr remaining))
                             (not (string->number (cadr remaining)))))
                (call-with-values
                  (lambda () (take-definition (cddr remaining) '()))
                  (lambda (body after-definition)
                    (run after-definition
                         (cons (cons (string-downcase (cadr remaining))
                                     (compile-definition body dictionary))
                               dictionary)
                         stack))))
              (run (cdr remaining)
                   dictionary
                   (execute (list (compile-token (car remaining) dictionary))
                            stack)))))))
