(import (rnrs))

(define (attacking? white black)
  (let ((wr (car white)) (wc (cadr white))
        (br (car black)) (bc (cadr black)))
    (assert (not (and (= wr br) (= wc bc))))
    (or (= wr br)
        (= wc bc)
        (= (abs (- wr br)) (abs (- wc bc))))))
