(ns nth-prime)

(defn nth-prime 
  "Returns the nth prime number."
  [n]
  (when (< n 1)
    (throw (IllegalArgumentException. "n must be positive")))
  (letfn [(prime? [candidate]
            (or (= candidate 2)
                (and (> candidate 2)
                     (odd? candidate)
                     (loop [divisor 3]
                       (cond
                         (> (* divisor divisor) candidate) true
                         (zero? (mod candidate divisor)) false
                         :else (recur (+ divisor 2)))))))]
    (loop [candidate 2
           found 0]
      (if (prime? candidate)
        (if (= (inc found) n)
          candidate
          (recur (inc candidate) (inc found)))
        (recur (inc candidate) found)))))
