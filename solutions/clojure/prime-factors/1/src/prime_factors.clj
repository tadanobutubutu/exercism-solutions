(ns prime-factors)

(defn of
  "Returns the prime factors of the given number."
  [num]
  (loop [remaining num
         factor 2
         factors []]
    (cond
      (= remaining 1) factors
      (> (*' factor factor) remaining) (conj factors remaining)
      (zero? (mod remaining factor))
      (recur (quot remaining factor) factor (conj factors factor))
      :else (recur remaining (inc factor) factors)))
