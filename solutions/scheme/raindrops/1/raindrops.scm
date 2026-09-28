(import (rnrs))

(define (convert number)
  (let ((sounds
          (string-append
            (if (= (mod number 3) 0) "Pling" "")
            (if (= (mod number 5) 0) "Plang" "")
            (if (= (mod number 7) 0) "Plong" ""))))
    (if (string=? sounds "") (number->string number) sounds)))
