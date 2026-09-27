(ns sum-of-multiples)

(defn sum-of-multiples
  "Calculates the sum of multiples of the given numbers
  that are less than the limit."
  [numbers limit]
  (reduce +
          (filter (fn [candidate]
                    (some (fn [factor]
                            (and (not (zero? factor))
                                 (zero? (mod candidate factor))))
                          numbers))
                  (range 1 limit)))
