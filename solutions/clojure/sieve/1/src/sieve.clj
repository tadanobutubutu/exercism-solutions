(ns sieve)

(defn sieve
  "Returns the primes that are less than or equal to num."
  [num]
  (let [limit (long (Math/sqrt num))
        composites (reduce (fn [marked candidate]
                             (if (contains? marked candidate)
                               marked
                               (into marked (range (* candidate candidate)
                                                   (inc num)
                                                   candidate)))
                           #{}
                           (range 2 (inc limit)))]
    (vec (remove composites (range 2 (inc num)))))
